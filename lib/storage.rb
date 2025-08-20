# Storage module
# Todo: Add configuration option

require "pathname"

module Storage
  # Store data like the access token in a simple key/value storage
  #
  # Example:
  #   >> Storage.set("hello", {})
  #   => 
  #   >> Storage.get("hello")
  #   => {}
  #
  # Arguments:
  #   key: string
  #   data: hash
  def self.set(key, data = {})
    p = Pathname.new("./tmp")
    if p.directory? == false
      STDERR.puts "TMP is not a folder"
    end

    f = File.new(p.join("#{key}.json"), 'w')
    f.write data.to_json
    f.close

    File.size(p.join("#{key}.json")) > 0
  end

  def self.get(key)
    p = Pathname.new("./tmp")

    if File.exist?(p.join("#{key}.json")) == false
      STDERROR.puts "The file #{key} does not exist"
    end

    JSON.parse(File.read(p.join("#{key}.json")))
  end
end
