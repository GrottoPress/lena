struct Lena::Workspace
  include Resource

  getter archived_at : Time?
  getter created_at : Time?
  getter display_color : String?
  getter id : String?
  getter name : String?
  getter data_residency : DataResidency?
end
