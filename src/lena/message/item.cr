struct Lena::Message::Item
  include Response

  @[JSON::Field(ignore: true)]
  getter data : Message? do
    return unless type.try(&.message?)
    Message.from_json(json_unmapped.to_json)
  end
end
