## API Key

An API key is represented as `Lena::ApiKey`.

See <https://platform.claude.com/docs/en/api/admin/api_keys/retrieve> for the raw JSON schema.

Note: API keys must be created through the Claude Console UI. The Admin API only supports listing, retrieving, and updating existing API keys.

### Usage Examples

1. List API keys:

   ```crystal
   response = client.api_keys.list

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |api_keys|
       api_keys.each do |api_key|
         puts api_key.id
         puts api_key.name
         # ...
       end
     end
   end
   ```

2. Fetch API key:

   ```crystal
   response = client.api_keys.fetch("apikey_01Rj2N8SVvo6BePZj99NhmiT")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |api_key|
       puts api_key.id
       puts api_key.name
       puts api_key.status
       puts api_key.workspace_id
       # ...
     end
   end
   ```

3. Update API key:

   ```crystal
   response = client.api_keys.update(
     "apikey_01Rj2N8SVvo6BePZj99NhmiT",
     name: "Updated Name",
     status: "inactive"
   )

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |api_key|
       puts api_key.id
       puts api_key.name
       puts api_key.status
       # ...
     end
   end
   ```
