struct Lena::MessageBatch::Result
  enum Type
    Succeeded
    Errored
    Canceled
    Expired
  end

  include Resource

  @result : {error: Error?, message: Message?, type: Type}?

  getter custom_id : String?

  macro method_missing(method)
    @result.try(&.[:{{ method.name }}])
  end
end
