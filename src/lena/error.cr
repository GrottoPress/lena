struct Lena::Error
  include Resource

  getter message : String
  getter type : Type
end
