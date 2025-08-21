require "net/http"
require "uri"
require "json"
require "logger"
require "time"

module Authentication
  extend self

  @logger = Logger.new($stdout)

  def get_access_token(&callback)
    raise "No callback method passed as parameter" if callback.nil?

    uri = URI.parse("https://account.nshiftportal.com/idp/connect/token")
    headers = { "Content-Type": "application/x-www-form-urlencoded" }

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

    callback.call("token", body)

    body
  end

  def has_token_expired?(data = {})
    raise "The expires at key is missing" unless data.has_key?("expires_at")

    t = Time.parse(data["expires_at"])

    if t > Time.now
      false
    else
      true
    end
  end
end
