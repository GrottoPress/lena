## Client

A *client* is responsible for querying all API *endpoints*, and returning *response*s from the API server.

You may instantiate a client using a pre-generated API key:

```crystal
client = Lena.new(api_key: "api-key-here")
```

From here on, you are ready to query *endpoint*s using the `client` client you just created.
