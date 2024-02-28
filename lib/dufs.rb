# frozen_string_literal: true

require_relative 'dufs/version'
require_relative 'dufs/api'

module Dufs
  class Error < StandardError; end
  # Your code goes here...

  class Unauthorized < Error; end
  class InvalidDestination < Error; end
  class FileOrDirNotFound < Error; end
  class FileOrDirAlreadyExists < Error; end
  class UnknownError < Error; end
end