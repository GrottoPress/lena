struct Lena::ApiKey
  enum Status
    Active
    Inactive
    Archived
  end

  include Resource

  getter created_at : Time?
  getter created_by : CreatedBy?
  getter id : String?
  getter name : String?
  getter partial_key_hint : String?
  getter status : String?
  getter workspace_id : String?
end
