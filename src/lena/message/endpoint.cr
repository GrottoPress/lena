struct Lena::Message::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  def create(headers = nil, **params) : Item
    response = @client.post(uri.path, headers, params.to_json)
    Item.from_json(response)
  end

  def count_tokens(headers = nil, **params) : Usage::Item
    path = "#{uri.path}/count_tokens"
    response = @client.post(path, headers, params.to_json)

    Usage::Item.from_json(response)
  end

  getter uri : URI do
    URI.parse(@client.uri.to_s).tap { |uri| uri.path += "/messages" }
  end
end
