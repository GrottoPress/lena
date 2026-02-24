module Lena::Response
  enum Type
    Error
    Message
    MessageBatch
    MessageBatchDeleted
    Model
  end

  macro included
    include Lena::Resource

    getter error : Lena::Error?
    getter organization_id : String?
    getter request_id : String?
    getter type : Lena::Response::Type?

    def self.from_json(response : HTTP::Client::Response) : self
      from_json(response.body).set_additional_properties(response)
    end

    protected def set_additional_properties(response : HTTP::Client::Response)
      @organization_id = response.headers["Anthropic-Organization-ID"]?
      @request_id = response.headers["Request-ID"]?

      self
    end
  end
end
