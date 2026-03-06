## Invite

An invite is represented as `Lena::Invite`.

See <https://platform.claude.com/docs/en/api/admin/invites/create> for the raw JSON schema.

### Usage Examples

1. List invites:

   ```crystal
   response = client.invites.list

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |invites|
       invites.each do |invite|
         puts invite.id
         puts invite.email
         # ...
       end
     end
   end
   ```

2. Fetch invite:

   ```crystal
   response = client.invites.fetch("invite-123456")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |invite|
       puts invite.invited_at.try(&.to_unix)
       puts invite.status.try(&.pending?)
       # ...
     end
   end
   ```

3. Create invite:

   ```crystal
   response = client.invites.create(
     email: "user@example.com",
     role: "admin"
   )

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |invite|
       puts invite.id
       puts invite.role
       # ...
     end
   end
   ```

4. Delete invite:

   ```crystal
   response = client.invites.delete("invite-123456")

   if response.error
     response.error.try do |error|
       puts error.type
       puts error.message
       # ...
     end
   else
     response.data.try do |invite|
       puts invite.id
       puts invite.email
       # ...
     end
   end
   ```
