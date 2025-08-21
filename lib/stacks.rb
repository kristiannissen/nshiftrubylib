require "dotenv/load"
require "net/http"
require "json"
require "logger"

module Stacks
  extend self
  @logger = Logger.new($stdout)

  def get_stacks(actor_id, access_token)
    uri = URI.parse("https://demo.shipmentserver.com:8080/ShipServer/#{actor_id}/stacks")
    headers = {
      "Authorization": "bearer #{access_token}}",
      "Content-Type": "application/json",
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Get.new(uri.request_uri, headers)

    res = http.request(req)
    body = JSON.parse(res.body)

    raise "Error #{body["Message"]}" if body.has_key?("ErrorType")

    body
  end
end
