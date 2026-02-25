struct Lena::MessageBatch::List
  include Response
  include Pagination

  getter data : Array(MessageBatch)?
end
