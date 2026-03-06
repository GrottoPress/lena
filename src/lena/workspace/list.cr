struct Lena::Workspace::List
  include Response
  include Pagination

  getter data : Array(Workspace)?
end
