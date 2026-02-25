struct Lena::Model
  include Resource

  getter created_at : Time?
  getter display_name : String?
  getter id : String?
end
