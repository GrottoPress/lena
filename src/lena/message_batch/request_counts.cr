class Lena::MessageBatch::RequestCounts
  include Resource

  getter canceled : Int32?
  getter errored : Int32?
  getter expired : Int32?
  getter processing : Int32?
  getter succeeded : Int32?
end
