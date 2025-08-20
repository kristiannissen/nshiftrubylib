require "dotenv/load"
require "net/http"
require "json"

module Stacks
  extend self

  def get_stacks
    uri = URI.parse("https://demo.shipmentserver.com:8080/ShipServer/#{ENV['ACTOR_ID']}/stacks")
    headers = {
      "Authorization": "bearer #{ENV['ACCESS_TOKEN']}",
      "Content-Type": "application/json"
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.request_uri, headers)

    res = http.request(req)
    body = JSON.parse(res.body)

    body
  end
end
