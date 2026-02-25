struct Lena::Usage::Item
  include Response

  @[JSON::Field(ignore: true)]
  getter data : Usage? do
    return unless type.try(&.message?)
    Usage.from_json(json_unmapped.to_json)
  end
end
