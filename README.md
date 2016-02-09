[![Code Climate](https://codeclimate.com/github/alexandru-calinoiu/fog-akamai/badges/gpa.svg)](https://codeclimate.com/github/alexandru-calinoiu/fog-akamai)

[![Test Coverage](https://codeclimate.com/github/alexandru-calinoiu/fog-akamai/badges/coverage.svg)](https://codeclimate.com/github/alexandru-calinoiu/fog-akamai/coverage)

# Fog Akamai

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/fog/storage`. To experiment with that code, run `bin/console` for an interactive prompt.

All the functionality of the net storage api is implemented except the really dangerous bit, quick-delete.

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
net_storage = Fog::Compute.new :provider => 'akamai'
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

## Roadmap

- implement ccu api

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexandru-calinoiu/fog-akamai.

