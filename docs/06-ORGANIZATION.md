## Organization

An organization is represented as `Lena::Organization`.

See <https://docs.anthropic.com/en/api/admin-api/organization> for the raw JSON schema.

### Usage Examples

1. Fetch current organization:

   ```crystal
   response = client.current_organization.fetch

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |organization|
       puts organization.id
       puts organization.name
       # ...
     end
   end
   ```
