# Ruby Client for Dufs (sigoden/dufs)

A ruby client for [sigoden/dufs](https://github.com/sigoden/dufs)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add dufs

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install dufs

## Usage

**Authenticate**

```ruby
# Create an instance of the DUFS API client.
# You can instantiate the client by passing credentials directly or by using environment variables.

# Using credentials directly:
api = Dufs::Api.new(user: 'user', pass: 'pass', url: 'http://1.2.3.4:5001/ns')

# Using environment variables:
# - DUFS_USER: Username for DUFS authentication
# - DUFS_PASS: Password for DUFS authentication
# - DUFS_URL: URL of the DUFS API
# Example:
#   export DUFS_USER=user
#   export DUFS_PASS=pass
#   export DUFS_URL=http://1.2.3.4:5001/namespace
#   api = Dufs::Api.new


# check if authenticated
api.authenticated? # => true
```

**Lists**

```ruby
# list all files and folders
api.lists.all

# search a file or folder
api.lists.search('your-file-or-folder-here')
```

**Directories**
```ruby
# create a directory
api.directories.create('path/to/dir')

# delete a directory (and its content)
api.directories.delete('path/to/dir')

# download a directory (in zip)
api.directories.download('path/to/dir')

# move a directory to new directory (or rename)
api.directories.move('original/path/to/dir', 'destination/path/to/dir')
```

**Files**

```ruby
# upload a file
api.files.upload('your/directory/file/path/test.txt', 'destination/path/test.txt')

# delete a file
api.files.delete('path/test.txt')

# download a file
api.files.download('path/to.file.txt')
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
