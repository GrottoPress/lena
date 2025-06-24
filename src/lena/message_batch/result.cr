class Lena::MessageBatch::Result
  include Resource

  struct Result
    include Resource

    getter error : Error?
    getter message : Message?
    getter type : Type
  end

  getter custom_id : String?
  getter result : Result?
end
