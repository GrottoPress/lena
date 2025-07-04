module Lena::Response
  enum Type
    Error
    Message
    MessageBatch
    Model
  end

  macro included
    include Lena::Resource

    getter error : Lena::Error?
    getter organization_id : String?
    getter request_id : String?
    getter type : Lena::Response::Type?

    protected def set_additional_properties(response : HTTP::Client::Response)
      @organization_id = response.headers["Anthropic-Organization-ID"]?
      @request_id = response.headers["Request-ID"]?

      self
    end
  end
end
