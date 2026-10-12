[![CI](https://github.com/fog/fog-akamai/actions/workflows/ci.yml/badge.svg)](https://github.com/fog/fog-akamai/actions/workflows/ci.yml)

# Fog Akamai

A [fog](https://github.com/fog/fog) provider for Akamai NetStorage, built on the ObjectStore HTTP API (the spec is in `docs/NS_http_api_FS.pdf`).

All the functionality of the NetStorage API is implemented except the really dangerous bit, quick-delete.

Requires Ruby 3.3 or newer and fog-core 2.x.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fog-akamai'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fog-akamai

## Usage

Before you can use fog-akamai, you must require it in your application:

```ruby
require 'fog/akamai'
```

Since it's a bad practice to have your credentials in source code, you should load them from default fog configuration file: ```~/.fog```. This file could look like this:

```
default:
  akamai_host:     <YOUR_AKAMAIHOST>
  akamai_key_name: <YOUR_KEY_NAME>
  akamai_key:      <YOU_KEY>
  akamai_cp_code:  <YOU_CP_CODE>
```

You can get more detail about how to obtain this credential form [this doc](https://control.akamai.com/dl/customers/NS/NS_Config_FS.pdf)

### Connecting to NetStorage service

```ruby
net_storage = Fog::Storage.new(provider: 'akamai')
```

You can also pass the credentials explicitly:

```ruby
net_storage = Fog::Storage.new(
  provider: 'akamai',
  akamai_host: '<YOUR_AKAMAIHOST>',
  akamai_key_name: '<YOUR_KEY_NAME>',
  akamai_key: '<YOU_KEY>',
  akamai_cp_code: '<YOU_CP_CODE>'
)
```

### To get a directory:

```ruby
directory = net_storage.directories.get('/path')
```

### To check if a file exists:

```ruby
directory.files.stat('file.ext')
```

### To upload a file:

```ruby
directory.files.create(directory: directory, body: file_body, key: file_name)
```

### Upgrading from 0.5

The service class is now `Fog::Akamai::Storage`. `Fog::Storage::Akamai` still works but is deprecated and will be removed in a future major release. If you only use `Fog::Storage.new(provider: 'akamai')` nothing changes. See the [changelog](CHANGELOG.md) for the other changes.

## Roadmap

- implement ccu api

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake` to run the tests and RuboCop (`bundle exec rake test` runs only the tests). You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb` and the changelog, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fog/fog-akamai.
