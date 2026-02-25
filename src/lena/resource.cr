module Lena::Resource
  macro included
    include JSON::Serializable
    include JSON::Serializable::Unmapped
  end
end
