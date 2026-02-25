struct Lena::Message
  include Resource

  getter container : Container?
  getter content : Array(Content)?
  getter id : String?
  getter model : String?
  getter role : Role?
  getter stop_reason : StopReason?
  getter stop_sequence : String?
  getter usage : Usage?
end
