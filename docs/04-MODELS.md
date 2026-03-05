## Models

A model is represented as `Lena::Model`.

See <https://docs.anthropic.com/en/api/models> for the raw JSON schema.

### Model Constants

The following constants are available, representing models the API exposes:

- `Lena::Model::OPUS_4_6`
- `Lena::Model::OPUS_4_5`
- `Lena::Model::OPUS_4_5_20251101`
- `Lena::Model::OPUS_4_1`
- `Lena::Model::OPUS_4_1_20250805`
- `Lena::Model::OPUS_4_0`
- `Lena::Model::OPUS_4_0_20250514`
- `Lena::Model::SONNET_4_6`
- `Lena::Model::SONNET_4_5`
- `Lena::Model::SONNET_4_5_20250929`
- `Lena::Model::SONNET_4_0`
- `Lena::Model::SONNET_4_0_20250514`
- `Lena::Model::HAIKU_4_5`
- `Lena::Model::HAIKU_4_5_20251001`
- `Lena::Model::HAIKU_3_0_20240307`

### Usage Examples

1. Fetch a model:

   ```crystal
   response = client.models.fetch(id: Lena::Model::OPUS_4_1)

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
