# Lena

*Lena* is a low-level API client for *Anthropic (Claude AI)*. It features an intuitive interface that maps directly to the *Anthropic* API.

### Usage Examples

```crystal
# Create a new client
client = Lena.new(api_key: "anthropic-api-key")
```

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
     response.data.try &.each do |message|
       puts message.container.try &.id
       puts message.id

       message.content.try &.each do |content|
         puts content.data
         puts content.text
         puts content.type
         # ...
       end
     end

     # ...
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

## Documentation

Find the complete documentation in the `docs/` directory of this repository.

## Development

Generate an API key from your Anthropic [account](https://console.anthropic.com).

Create a `.env.sh` file:

```bash
#!/usr/bin/env bash
#
export ANTHROPIC_API_KEY='your-anthropic-api-key-here'
```

Update the file with your own details. Then run tests with `source .env.sh && crystal spec`.

**IMPORTANT**: Remember to set permissions for your env file to `0600` or stricter: `chmod 0600 .env*`.

## Contributing

1. [Fork it](https://github.com/GrottoPress/lena/fork)
1. Switch to the `master` branch: `git checkout master`
1. Create your feature branch: `git checkout -b my-new-feature`
1. Make your changes, updating changelog and documentation as appropriate.
1. Commit your changes: `git commit`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a new *Pull Request* against the `GrottoPress:master` branch.
