struct Lena::Invite::List
  include Response
  include Pagination

  getter data : Array(Invite)?
end
