class Lena::Model::List
  include Response

  getter data : Array(Model)?
  getter first_id : String?
  getter? has_more : Bool?
  getter last_id : String?
end
