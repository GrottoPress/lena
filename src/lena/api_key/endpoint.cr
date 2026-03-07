struct Lena::ApiKey::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  def fetch(id : String, headers = nil) : Item
    path = "#{uri.path}/#{id}"
    response = @client.get(path, headers)

    Item.from_json(response)
  end

  def list(headers = nil, **params) : List
    resource = "#{uri.path}?#{URI::Params.encode(params)}"
    response = @client.get(resource, headers)

    List.from_json(response)
  end

  def update(id : String, headers = nil, **params) : Item
    path = "#{uri.path}/#{id}"
    response = @client.post(path, headers, params.to_json)

    Item.from_json(response)
  end

  getter uri : URI do
    URI.parse(@client.organizations.uri.to_s).tap do |uri|
      uri.path += "/api_keys"
    end
  end
end
