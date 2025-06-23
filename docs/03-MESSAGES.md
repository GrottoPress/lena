## Messages

A message is represented as `Lena::Message`.

See <https://docs.anthropic.com/en/api/messages> for the raw JSON schema.

### Usage Examples

1. Send messages:

   ```crystal
   response = client.messages.create(
     model: "claude-3-7-sonnet-20250219",
     max_tokens: 1024,
     messages: [{role: "user", content: "Hello, world"}]
   )

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     puts response.container.try(&.id)
     puts response.id

     response.content.try &.each do |content|
       puts content.data
       puts content.text
       puts content.type
       # ...
     end

     # ...
   end
   ```

1. Count tokens:

   ```crystal
   response = client.messages.count_tokens(
     model: "claude-3-7-sonnet-20250219",
     messages: [{role: "user", content: "Hello, world"}]
   )

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     puts response.input_tokens
     # ...
   end
   ```
