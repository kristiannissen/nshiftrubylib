require "net/http"
# require "dotenv/load"
require "uri"
require "json"
require "logger"
# require "storage"

module Authentication
  extend self

  @logger = Logger.new($stdout)
  # Todo: This should be extracted from the module body and instead
  #       be based in as a parameter, the config should be done outside
  #       of the module and then the required "set" method be passed as
  #       a parameter arg
  # Storage.config.folder = "./tmp"

  # def one(k, v)
  #   
  # end
  #
  # def two(k, v, &callback)
  #   callback.call(k, v)
  # end
  # Fixme: Error handling for &callback
  def get_access_token(&callback)
    raise "No callback method passed as parameter" if callback.nil?

    uri = URI.parse("https://account.nshiftportal.com/idp/connect/token")
    headers = {"Content-Type": "application/x-www-form-urlencoded"}

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.request_uri, headers)
    req.set_form_data("grant_type" => "client_credentials",
                      "client_id" => ENV["CLIENT_ID"],
                      "client_secret" => ENV["CLIENT_SECRET"])

    res = http.request(req)
    body = JSON.parse(res.body)

    if body.has_key?("access_token") == false
      @logger.error(body)
      raise "No access token returned"
    end

    body["expires_at"] = Time.now + body["expires_in"].to_i

    # Storage.set("token", body)
    callback.call("token", body)

    body
  end

  def has_token_expired?
    true
  end
end
