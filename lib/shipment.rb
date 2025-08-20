require "dotenv/load"
require "net/http"
require "json"

module Shipment

  def self.post_shipment(payload)
    uri = URI.parse("https://demo.shipmentserver.com:8080/ShipServer/#{ENV['ACTOR_ID']}/shipments")
    headers = {
      "Authorization": "bearer #{ENV['ACCESS_TOKEN']}",
      "Content-Type": "application/json"
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.request_uri, headers)

    req.body = payload.to_json

    res = http.request(req)
    body = JSON.parse(res.body)

    if body.has_key?("ErrorType")
      raise "ERROR #{body['Message']}"
    end

    body
  end
end
