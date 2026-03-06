struct Lena::Invite::Item
  include Response

  @[JSON::Field(ignore: true)]
  getter data : Invite? do
    return unless type.try(&.invite?) || type.try(&.invite_deleted?)
    Invite.from_json(json_unmapped.to_json)
  end
end
