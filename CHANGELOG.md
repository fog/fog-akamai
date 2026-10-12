# Changelog

## 0.6.0 - Unreleased

### Breaking

- Requires Ruby >= 3.3. Older Rubies are no longer supported.
- Requires fog-core ~> 2.1 (was ~> 1.27). The unused fog-json dependency is gone.

### Changed

- The service class is now `Fog::Akamai::Storage`, the layout fog-core 2 expects. `Fog::Storage::Akamai` still works as a deprecated alias and will be removed in a future major release. `Fog::Storage.new(provider: 'akamai')` is unchanged.
- The response parsers moved to `Fog::Parsers::Akamai::Storage` (internal API).
- The published gem only contains `lib/`, the README, the license and this changelog.

### Fixed

- Request signing no longer depends on `OpenSSL::Digest::Digest` or the `Base64` library, which are gone on current Rubies.
- `CGI.escape` is required explicitly, so `rename` and `symlink` work without a full `cgi`.
- `fog-core` no longer logs two deprecation lines on every `Fog::Storage.new`.
- Uploading a `nil` body raised `NoMethodError` instead of `ArgumentError`.
- `rake test` globbed a non-existent `tests/` directory and ran nothing.

### Development

- CI moved from Travis to GitHub Actions (Ruby 3.3, 3.4, 4.0, RuboCop, and fog-core/fog-xml master).
- Code Climate is gone; SimpleCov writes a local coverage report.
- Tests run on minitest 6 and webmock 3; RuboCop is on 1.x.

Earlier releases are listed on the [GitHub tags](https://github.com/fog/fog-akamai/tags).
