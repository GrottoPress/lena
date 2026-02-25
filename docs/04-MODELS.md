## Models

A model is represented as `Lena::Model`.

See <https://docs.anthropic.com/en/api/models> for the raw JSON schema.

### Usage Examples

1. Fetch a model:

   ```crystal
   response = client.models.fetch(id: "claude-3-7-sonnet-20250219")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.model
       # ...
     end
   else
     response.data.try do |model|
       puts model.created_at.try(&.day_of_week)
       puts model.display_name
       puts model.id
       # ...
     end
   end
   ```

1. List models:

   ```crystal
   response = client.models.list(limit: 10)

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try &.each do |model|
       puts model.created_at
       puts model.display_name
       puts model.id
       # ...
     end
   end
   ```
