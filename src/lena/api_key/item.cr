struct Lena::ApiKey::Item
  include Response

  @[JSON::Field(ignore: true)]
  getter data : ApiKey? do
    return unless type.try(&.api_key?)
    ApiKey.from_json(json_unmapped.to_json)
  end
end
