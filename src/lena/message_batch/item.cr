struct Lena::MessageBatch::Item
  include Response

  @[JSON::Field(ignore: true)]
  getter data : MessageBatch? do
    return unless type.try(&.message_batch?)
    MessageBatch.from_json(json_unmapped.to_json)
  end
end
