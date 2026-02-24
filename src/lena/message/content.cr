struct Lena::Message::Content
  enum Type
    Text
    Thinking
    RedactedThinking
    ToolUse
    ToolResult
    ServerToolUse
    WebSearchToolResult
    CodeExecutionToolResult
    McpToolUse
    McpToolResult
    ContainerUpload
    Image
  end

  include Resource

  getter content : JSON::Any?
  getter data : String?
  getter file_id : String?
  getter id : String?
  getter input : JSON::Any?
  getter? is_error : Bool?
  getter name : String?
  getter server_name : String?
  getter signature : String?
  getter text : String?
  getter thinking : String?
  getter tool_use_id : String?
  getter type : Type
end
