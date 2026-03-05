struct Lena::User::Item
  include Response

  @[JSON::Field(ignore: true)]
  getter data : User? do
    return unless type.try(&.user?) || type.try(&.user_deleted?)
    User.from_json(json_unmapped.to_json)
  end
end
