require "net/http"
require "dotenv/load"
require "uri"
require "json"
require "logger"

module Authentication

  @logger = Logger.new($stdout)

  def self.get_access_token
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
      STDERR.puts "No access token returned"
    end

    body["ttl"] = Time.now + body["expires_in"].to_i

    body
  end
end
