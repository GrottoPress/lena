require "http/client"
require "json"

require "./lena/version"
require "./lena/endpoint"
require "./lena/resource"
require "./lena/**"

struct Lena
  @@http_client = HTTP::Client.new(uri)

  def initialize(api_key : String)
    set_headers(api_key)
  end

  forward_missing_to @@http_client

  def messages : Message::Endpoint
    Message::Endpoint.new(self)
  end

  def models : Model::Endpoint
    Model::Endpoint.new(self)
  end

  def self.uri : URI
    URI.parse("https://api.anthropic.com/v1")
  end

  private def set_headers(api_key)
    @@http_client.before_request do |request|
      set_content_type(request.headers)
      set_user_agent(request.headers)
      set_anthropic_version(request.headers)
      set_api_key(request.headers, api_key)
    end
  end

  private def set_anthropic_version(headers)
    headers["Anthropic-Version"] = "2023-06-01"
  end

  private def set_api_key(headers, api_key)
    headers["X-API-Key"] = api_key
  end

  private def set_content_type(headers)
    headers["Content-Type"] = "application/json"
  end

  private def set_user_agent(headers)
    headers["User-Agent"] = "Lena/#{Lena::VERSION} \
      (+https://github.com/GrottoPress/lena)"
  end
end
