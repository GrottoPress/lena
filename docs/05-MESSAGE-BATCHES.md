## Message Batches

A message batch is represented as `Lena::MessageBatch`.

See <https://docs.anthropic.com/en/api/message-batches> for the raw JSON schema.

### Usage Examples

1. Create a message batch:

   ```crystal
   response = client.message_batches.create(
     requests: [
       {
         custom_id: "request-1",
         params: {
           model: "claude-3-7-sonnet-20250219",
           max_tokens: 1024,
           messages: [{role: "user", content: "Hello, world"}]
         }
       },
       {
         custom_id: "request-2",
         params: {
           model: "claude-3-7-sonnet-20250219",
           max_tokens: 1024,
           messages: [{role: "user", content: "How are you?"}]
         }
       }
     ]
   )

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |batch|
       puts batch.id
       puts batch.processing_status
       puts batch.created_at
       # ...
     end
   end
   ```

1. Fetch a message batch:

   ```crystal
   response = client.message_batches.fetch(id: "msgbatch_01ABC123")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |batch|
       puts batch.id
       puts batch.processing_status
       puts batch.request_counts.try(&.processing)
       puts batch.request_counts.try(&.succeeded)
       puts batch.request_counts.try(&.errored)
       puts batch.request_counts.try(&.canceled)
       puts batch.request_counts.try(&.expired)
       # ...
     end
   end
   ```

1. List message batches:

   ```crystal
   response = client.message_batches.list

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try &.each do |batch|
       puts batch.id
       puts batch.processing_status
       puts batch.created_at
       # ...
     end
   end
   ```

1. Cancel a message batch:

   ```crystal
   response = client.message_batches.cancel(id: "msgbatch_01ABC123")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |batch|
       puts batch.id
       puts batch.processing_status
       puts batch.cancel_initiated_at
       # ...
     end
   end
   ```

1. Delete a message batch:

   ```crystal
   response = client.message_batches.delete(id: "msgbatch_01ABC123")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |batch|
       puts batch.id
       puts batch.archived_at
       # ...
     end
   end
   ```

1. Retrieve message batch results:

   ```crystal
   response = client.message_batches.results(id: "msgbatch_01ABC123")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try &.each do |result|
       puts result.custom_id
       puts result.type

       if result.type.try(&.succeeded?)
         puts result.message.try(&.id)
         puts result.message.try(&.content)
       elsif result.type.try(&.errored?)
         puts result.error.try(&.type)
         puts result.error.try(&.message)
       end
       # ...
     end
   end
   ```
