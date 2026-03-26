module Lena::Endpoint
  macro included
    @client : Lena

    private def clone_uri(uri)
      URI.new(
        uri.scheme,
        uri.host,
        uri.port,
        uri.path,
        uri.query,
        uri.user,
        uri.password,
        uri.fragment
      )
    end
  end
end
