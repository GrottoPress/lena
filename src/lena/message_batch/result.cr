struct Lena::MessageBatch::Result
  include Resource

  @result : {error: Error?, message: Message?, type: Type}?

  getter custom_id : String?

  macro method_missing(method)
    @result.try(&.[:{{ method.name }}])
  end
end
