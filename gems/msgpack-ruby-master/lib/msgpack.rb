require "gems/msgpack-ruby-master/lib/msgpack/version"

if defined?(RUBY_ENGINE) && RUBY_ENGINE == "jruby" # This is same with `/java/ =~ RUBY_VERSION`
  require "gems/msgpack-ruby-master/lib/msgpack/msgpack.jar"
  JRuby::Util.load_ext("org.msgpack.jruby.MessagePackLibrary")
#else
  #require "gems/msgpack-ruby-master/lib/msgpack/msgpack"
end

require "gems/msgpack-ruby-master/lib/msgpack/packer"
require "gems/msgpack-ruby-master/lib/msgpack/unpacker"
require "gems/msgpack-ruby-master/lib/msgpack/factory"
require "gems/msgpack-ruby-master/lib/msgpack/symbol"
require "gems/msgpack-ruby-master/lib/msgpack/core_ext"
require "gems/msgpack-ruby-master/lib/msgpack/timestamp"
#trying to load time doesnt work for us
#require "gems/msgpack-ruby-master/lib/msgpack/time"
#puts 'time loaded'

module MessagePack
  DefaultFactory = MessagePack::Factory.new
  DEFAULT_EMPTY_PARAMS = {}.freeze

  def load(src, param = nil)
    unpacker = nil

    if src.is_a? String
      unpacker = DefaultFactory.unpacker param || DEFAULT_EMPTY_PARAMS
      unpacker.feed_reference src
    else
      unpacker = DefaultFactory.unpacker src, param || DEFAULT_EMPTY_PARAMS
    end

    unpacker.full_unpack
  end
  alias :unpack :load

  module_function :load
  module_function :unpack

  def pack(v, *rest)
    packer = DefaultFactory.packer(*rest)
    packer.write v
    packer.full_pack
  end
  alias :dump :pack

  module_function :pack
  module_function :dump
end
