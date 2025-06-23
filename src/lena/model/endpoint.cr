struct Lena::Model::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  def fetch(id : String, headers = nil) : Item
    path = "#{self.class.uri.path}/#{id}"
    response = @client.get(path, headers)

    Item.from_json(response.body).set_additional_properties(response)
  end

  def list(headers = nil, **params) : List
    resource = "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    response = @client.get(resource, headers)

    List.from_json(response.body).set_additional_properties(response)
  end

  def self.uri : URI
    Lena.uri.tap { |uri| uri.path += "/models" }
  end
end
