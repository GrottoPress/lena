struct Lena::MessageBatch::Result
  include Resource

  @result : {error: Error?, message: Message?, type: Type}?

  getter custom_id : String?

  def error : Error?
    @result.try(&.[:error])
  end

  def message : Message?
    @result.try(&.[:message])
  end

  def type : Type?
    @result.try(&.[:type])
  end
end
