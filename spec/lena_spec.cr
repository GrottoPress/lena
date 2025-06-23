require "./spec_helper"

describe Lena do
  it "handles error" do
    api_key = "x7y8z9"
    organization_id = "d4e5f6"
    request_id = "a1b2c3"

    body = <<-'JSON'
      {
        "error": {
          "message": "Invalid request",
          "type": "invalid_request_error"
        },
        "type": "error"
      }
      JSON

    WebMock.stub(:POST, "https://api.anthropic.com/v1/messages")
      .with(headers: {"X-API-Key" => api_key})
      .to_return(body: body, headers: {
        "anthropic-organization-id" => organization_id,
        "request-id" => request_id
      })

    client = Lena.new(api_key)

    response = client.messages.create(
      model: "non-existent-model",
      max_tokens: 1024,
      messages: [{role: "user", content: "Hello, world"}]
    )

    response.type.try(&.error?).should be_true
    response.request_id.should eq(request_id)
    response.organization_id.should eq(organization_id)

    response.error.should be_a(Lena::Error)
    response.error.try(&.type.invalid_request_error?).should be_true
  end

  ENV["ANTHROPIC_API_KEY"]?.presence.try do |api_key|
    it "connects to Anthropic" do
      WebMock.allow_net_connect = true

      client = Lena.new(api_key)
      response = client.models.list

      response.type.try(&.model?).should be_true
      response.should be_a(Lena::Model::List)
    end
  end
end
