# Storage module
# Todo: Add configuration option

require "pathname"
require "ostruct"

module Storage
  extend self
  # Store data like the access token in a simple key/value storage
  #
  # Example:
  #   >> Storage.set("hello", {})
  #   => int|0 
  #   >> Storage.get("hello")
  #   => {}
  #
  # Arguments:
  #   key: string
  #   data: hash
  CONFIG_ATTR = %i(folder)

  def set(key = "", data = {})
    p = Pathname.new(config.folder)
    if p.directory? == false
      STDERR.puts "#{config.folder} is not a folder"
    end

    f = File.new(p.join("#{key}.json"), 'w')
    f.write data.to_json
    f.close

    File.size(p.join("#{key}.json")) > 0
  end

  def get(key)
    p = Pathname.new(config.folder)
    if File.exist?(p.join("#{key}.json")) == false
      STDERROR.puts "The file #{key} does not exist"
    end

    JSON.parse(File.read(p.join("#{key}.json")))
  end
  #
  # https://kirillplatonov.com/posts/configure-ruby-module/
  #
  def configure
    @config ||= Struct.new(*CONFIG_ATTR).new
    yield(@config) if block_given?
    @config
  end

  def config
    @config || configure
  end
end
