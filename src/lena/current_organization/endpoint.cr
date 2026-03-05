struct Lena::CurrentOrganization::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  def fetch(headers = nil) : Organization::Item
    response = @client.get(uri.path, headers)
    Organization::Item.from_json(response)
  end

  getter uri : URI do
    URI.parse(@client.uri.to_s).tap { |uri| uri.path += "/organizations/me" }
  end
end
