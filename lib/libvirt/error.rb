module Libvirt
  # Represents the actual `libvirt` error object which most erroneous
  # events set. This contains important information such as the message,
  # domain, etc.
  class Error
    attr_reader :interface

    # Gets the last error (if there is one) and returns the {Error}
    # representing it.
    #
    # @return [Error]
    def self.last_error
      new(FFI::Libvirt.virGetLastError)
    end

    # Initializes a new error object. This shouldn't be called publicly.
    # Instead use {last_error} or obtain the error from any of the exceptions
    # which the library raises.
    def initialize(pointer)
      @interface = FFI::Libvirt::Error.new(pointer)
    end

    # Returns the error code of the error. Internally, this is represented
    # by a C `enum`, so this will actually return a Ruby `Symbol` representation
    # of the error.
    #
    # @return [Symbol]
    def code
      interface[:code]
    end

    # Returns the domain or "category" in which this error occured. This
    # is represented internally as a C `enum`, so this will actually return
    # a Ruby `symbol`.
    #
    # @return [Symbol]
    def domain
      interface[:domain]
    end

    # Returns a human-friendly message related to the error.
    #
    # @return [String]
    def message
      interface[:message]
    end
  end
end