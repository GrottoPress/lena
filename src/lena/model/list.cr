class Lena::Model::List
  include Response
  include Pagination

  getter data : Array(Model)?
end
