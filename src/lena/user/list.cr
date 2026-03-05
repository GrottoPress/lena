struct Lena::User::List
  include Response
  include Pagination

  getter data : Array(User)?
end
