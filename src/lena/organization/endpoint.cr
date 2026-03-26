struct Lena::Organization::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  getter uri : URI do
    clone_uri(@client.uri).tap { |uri| uri.path += "/organizations" }
  end
end
