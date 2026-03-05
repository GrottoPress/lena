struct Lena::Organization::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  getter uri : URI do
    URI.parse(@client.uri.to_s).tap { |uri| uri.path += "/organizations" }
  end
end
