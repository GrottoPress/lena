struct Lena::Message::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  def create(headers = nil, **params) : Item
    response = @client.post(self.class.uri.path, headers, params.to_json)
    Item.from_json(response.body).set_additional_properties(response)
  end

  def count_tokens(headers = nil, **params) : Usage::Item
    path = "#{self.class.uri.path}/count_tokens"
    response = @client.post(path, headers, params.to_json)

    Usage::Item.from_json(response.body).set_additional_properties(response)
  end

  def self.uri : URI
    Lena.uri.tap { |uri| uri.path += "/messages" }
  end
end
