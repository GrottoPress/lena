require "../spec_helper"

describe Lena::Message::Endpoint do
  describe "#count_tokens" do
    it "returns token count" do
      api_key = "x7y8z9"
      model = "claude-3-7-sonnet-20250219"
      organization_id = "a1b2c3"

      body = <<-'JSON'
        {
          "input_tokens": 2095
        }
        JSON

      WebMock.stub(:POST, "https://api.anthropic.com/v1/messages/count_tokens")
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)

      response = client.messages.count_tokens(
        model: model,
        messages: [{role: "user", content: "Hello, world"}]
      )

      response.organization_id.should eq(organization_id)
      response.should be_a(Lena::Usage::Item)
    end
  end

  describe "#create" do
    it "sends message" do
      api_key = "x7y8z9"
      model = "claude-3-7-sonnet-20250219"
      request_id = "a1b2c3"

      body = <<-JSON
        {
          "content": [
            {
              "text": "Hi! My name is Claude.",
              "type": "text"
            }
          ],
          "id": "msg_013Zva2CMHLNnXjNJJKqJ2EF",
          "model": "#{model}",
          "role": "assistant",
          "stop_reason": "end_turn",
          "stop_sequence": null,
          "type": "message",
          "usage": {
            "input_tokens": 2095,
            "output_tokens": 503
          }
        }
        JSON

      WebMock.stub(:POST, "https://api.anthropic.com/v1/messages")
        .with(headers: {"X-API-Key" => api_key})
        .to_return(body: body, headers: {"request-id" => request_id})

      client = Lena.new(api_key)

      response = client.messages.create(
        model: model,
        max_tokens: 1024,
        messages: [{role: "user", content: "Hello, world"}]
      )

      response.type.try(&.message?).should be_true
      response.request_id.should eq(request_id)
      response.model.should eq(model)

      response.should be_a(Lena::Message::Item)
      response.usage.should be_a(Lena::Usage)
      response.content.should be_a(Array(Lena::Message::Content))
    end
  end
end
