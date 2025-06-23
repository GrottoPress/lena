module Lena::Response
  enum Type
    Error
    Message
    Model
  end

  macro included
    include Lena::Resource

    getter error : Lena::Error?
    getter organization_id : String?
    getter request_id : String?
    getter type : Lena::Response::Type?

    protected def set_additional_properties(http_response) : self
      @organization_id = http_response.headers["Anthropic-Organization-ID"]?
      @request_id = http_response.headers["Request-ID"]?

      self
    end
  end
end
