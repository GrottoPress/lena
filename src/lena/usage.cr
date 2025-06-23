class Lena::Usage
  include Resource

  getter cache_creation : CacheCreation?
  getter cache_creation_input_tokens : Int32?
  getter cache_read_input_tokens : Int32?
  getter input_tokens : Int32?
  getter output_tokens : Int32?
  getter server_tool_use : ServerToolUse?
  getter service_tier : ServiceTier?
end
