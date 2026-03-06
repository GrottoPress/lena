struct Lena::Workspace::Item
  include Response

  @[JSON::Field(ignore: true)]
  getter data : Workspace? do
    return unless type.try(&.workspace?)
    Workspace.from_json(json_unmapped.to_json)
  end
end
