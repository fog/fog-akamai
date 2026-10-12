# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

`fog-akamai` is a fog provider gem for Akamai NetStorage (the ObjectStore HTTP API; the spec is in `docs/NS_http_api_FS.pdf`). It implements every NetStorage action except quick-delete, which is left out on purpose. The gem requires Ruby >= 3.3 (`.ruby-version` pins 4.0.7 for development) and depends on fog-core 2.x and fog-xml. Development dependencies (minitest 6, minitest-mock, minitest-reporters, webmock 3, timecop, SimpleCov, RuboCop, rake) live in the `Gemfile`, not the gemspec.

## Commands

- Install deps: `bin/setup` (runs `bundle install`)
- Console: `bin/console`
- Tests and lint (the default task, also what CI runs): `bundle exec rake`
- Tests only: `bundle exec rake test`
- Lint: `bundle exec rubocop` (config in `.rubocop.yml`: TargetRubyVersion 3.3, line length 160, Style/Documentation off)
- Run one file: `bundle exec ruby -Itest -Ilib test/fog/akamai/requests/storage/upload_test.rb`
- Run one test: append `-n test_upload` (or `-n /pattern/`)
- Another Ruby: `mise exec ruby@3.3.5 -- bundle exec rake test`. CI runs 3.3, 3.4 and 4.0.
- Against fog-core/fog-xml master: `BUNDLE_GEMFILE=gemfiles/Gemfile-edge bundle exec rake test`

Tests need `test/` and `lib/` on the load path because they `require 'helpers/...'` and `require 'fog/akamai/storage_test_base'`. The Rakefile and the commands above already set that up.

Known quirks:

- On Ruby 4.0, fog-core 2.6.0 itself prints a `CGI library is removed` warning at load time, and a frozen-string-literal warning under `-w`. They come from fog-core, not from this gem.
- `Fog::Storage::Akamai` (the pre-0.6 constant) is a deprecated alias of `Fog::Akamai::Storage` and is meant to be removed in 1.0.
- `symlink` has no Mock implementation (issue #3); in mock mode fog-core raises `Fog::Errors::MockNotImplemented`.
- Model gaps: `File#get` and `File#destroy` are stubs that don't call the service yet, and `Files#all` returns `directory.files`.

## Architecture

The gem follows the standard fog provider layout, using the fog-core 2 `Fog::<Provider>::<Service>` namespace:

- `lib/fog/akamai.rb` registers the `Fog::Akamai` provider with a `:storage` service and autoloads `Fog::Akamai::Storage` (the autoload is what stops fog-core logging a deprecation on every `Fog::Storage.new`). `Fog::Akamai::Shared#full_path` joins a directory key and a path; models use it.
- `lib/fog/akamai/storage.rb` defines `Fog::Akamai::Storage < Fog::Service`, plus the deprecated `Fog::Storage::Akamai` alias at the bottom:
  - Required credentials: `akamai_host`, `akamai_key_name`, `akamai_key`, `akamai_cp_code` (usually from `~/.fog`). Optional: `scheme`/`port` (defaults https/443).
  - `Helpers#format_path` prefixes every path with `/<cp_code>`. Request methods take paths *without* the CP code; models strip it when building keys.
  - `Real#request` signs every call with the ACS headers (`X-Akamai-ACS-Auth-Data`, `-Auth-Sign` = Base64 HMAC-SHA256 over auth data + path + action, `-Action`). Each action must be listed in `VALID_ACTIONS`, or `acs_action` raises.
  - `Mock` keeps an in-memory class-level hash, `data`, keyed by the full `/<cp_code>/path`. Each value is `{ directory:, files: [], directories: [] }`, and file contents are stored at their own keys.
- `requests/storage/<action>.rb`: each file reopens `Real` and `Mock` and adds one method named after the NetStorage action (dir, mkdir, upload, download, stat, delete, du, mtime, rename, rmdir, symlink). **When adding an action**, add the file, register it with `request :name` in `storage.rb`, add it to `VALID_ACTIONS`, and implement both Real and Mock.
- `parsers/storage/` holds SAX parsers (`Fog::Parsers::Base`, namespaced `Fog::Parsers::Akamai::Storage`) for the XML responses. `Dir` handles both `dir` and `stat`, and splits `<file type="file|dir">` entries into `:files` and `:directories`.
- `models/storage/`: `Directories#get` calls `dir` and hydrates a `Directory` along with its `files` and `directories` sub-collections. `File#save` → `upload`, `touch` → `mtime`, `rename` → `rename`. `Files#get` → `download`, `stat` → `stat` (returns nil on 404).

## Tests

- Test framework: Minitest 6. `test/test_helper.rb` starts SimpleCov, requires `minitest/mock` (used for `Time.stub`/`SecureRandom.stub`) and auto-requires `test/support/*`, which set fake credentials (host `example-nsu.akamai.net`, cp_code `42`), enable webmock and use the minitest-reporters.
- `test/fog/akamai/storage_test_base.rb` defines two base classes:
  - `StorageTestBase`: real mode. HTTP is stubbed with the webmock helpers in `test/helpers/<action>_request_stub.rb` (stubbed paths include `/42`).
  - `MockStorageTestBase`: calls `Fog.mock!` and resets the mock data in teardown.
- Request tests usually define one class of each kind per action. Time-dependent mock assertions use `Timecop.freeze`.
- `test/fog/akamai_test.rb` covers provider loading: the namespace, no deprecation output (one test spawns a subprocess to check the load-time output), and the deprecated alias.
