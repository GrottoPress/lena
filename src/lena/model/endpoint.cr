struct Lena::Model::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  def fetch(id : String, headers = nil) : Item
    path = "#{uri.path}/#{id}"
    response = @client.get(path, headers)

    Item.from_json(response.body).set_additional_properties(response)
  end

  def list(headers = nil, **params) : List
    resource = "#{uri.path}?#{URI::Params.encode(params)}"
    response = @client.get(resource, headers)

    List.from_json(response.body).set_additional_properties(response)
  end

  getter uri : URI do
    URI.parse(@client.uri.to_s).tap { |uri| uri.path += "/models" }
  end
end
