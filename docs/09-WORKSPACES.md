## Workspace

A workspace is represented as `Lena::Workspace`.

See <https://platform.claude.com/docs/en/api/admin/workspaces/create> for the raw JSON schema.

### Usage Examples

1. List workspaces:

   ```crystal
   response = client.workspaces.list

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |workspaces|
       workspaces.each do |workspace|
         puts workspace.id
         puts workspace.name
         # ...
       end
     end
   end
   ```

2. Fetch workspace:

   ```crystal
   response = client.workspaces.fetch("wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |workspace|
       puts workspace.id
       puts workspace.name
       puts workspace.created_at.try(&.to_unix)
       # ...
     end
   end
   ```

3. Create workspace:

   ```crystal
   response = client.workspaces.create(name: "My Workspace")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |workspace|
       puts workspace.id
       puts workspace.name

       workspace.data_residency.try do |data_residency|
         puts data_residency.workspace_geo
         puts data_residency.default_inference_geo
         # ...
       end
       # ...
     end
   end
   ```

4. Update workspace:

   ```crystal
   response = client.workspaces.update("wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ", name: "Updated Name")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |workspace|
       puts workspace.display_color
       puts workspace.name
       # ...
     end
   end
   ```

5. Archive workspace:

   ```crystal
   response = client.workspaces.archive("wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |workspace|
       puts workspace.id
       puts workspace.archived_at.try(&.to_unix)
       # ...
     end
   end
   ```
