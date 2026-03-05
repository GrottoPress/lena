## User

A user is represented as `Lena::User`.

See <https://platform.claude.com/docs/en/api/admin/users/retrieve> for the raw JSON schema.

### Usage Examples

1. List users:

   ```crystal
   response = client.users.list

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |users|
       users.each do |user|
         puts user.id
         puts user.email
         # ...
       end
     end
   end
   ```

2. Fetch user:

   ```crystal
   response = client.users.fetch("user-123456")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |user|
       puts user.added_at.try(&.to_unix)
       puts user.role.try(&.developer?)
       # ...
     end
   end
   ```

3. Update user:

   ```crystal
   response = client.users.update("user-123456", role: "admin")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |user|
       puts user.name
       puts user.email
       # ...
     end
   end
   ```

4. Delete user:

   ```crystal
   response = client.users.delete("user-123456")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |user|
       puts user.id
       puts user.email
       # ...
     end
   end
   ```
