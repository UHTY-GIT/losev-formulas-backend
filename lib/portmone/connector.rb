require 'zlib'
require 'base64'
require 'json'

module Portmone
  module Connector

    PORTMONE_LINK_VERSION = '2'.freeze
    PORTMONE_LINK_URL = 'https://www.portmone.com.ua/r3/uk/autoinsurance?i='.freeze

    def self.create_link_for_pay!(data)

      source_data = {
        "v" => PORTMONE_LINK_VERSION,
        "payeeId" => data[:payee_id],
        "amount" => data[:amount],
        "description" => data[:description],
        "billNumber" => data[:order_id],
        "emailAddress" => data[:email],
        "successUrl" => data[:success_url]
      }

      gzip_buffer = StringIO.new("")
      gz = Zlib::GzipWriter.new(gzip_buffer)
      gz.write(source_data.to_json)
      gz.close

      compressed_data = gzip_buffer.string
      encoded_data = Base64.strict_encode64(compressed_data)

      PORTMONE_LINK_URL + encoded_data
    end

    def self.make_post_request(url, data, token)

      http = Net::HTTP.new(url.port, url.host)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)

      request["accept"] = 'application/json'
      request["content-type"] = 'application/json'
      request["authorization"] = "bearer #{token}"




    end
  end
end