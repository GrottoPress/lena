struct Lena::ApiKey::List
  include Response
  include Pagination

  getter data : Array(ApiKey)?
end
