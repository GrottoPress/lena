struct Lena::Organization::Item
  include Response

  @[JSON::Field(ignore: true)]
  getter data : Organization? do
    return unless type.try(&.organization?)
    Organization.from_json(json_unmapped.to_json)
  end
end
