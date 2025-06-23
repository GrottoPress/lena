require "../spec_helper"

describe Lena::Model::Endpoint do
  describe "#fetch" do
    it "gets model" do
      api_key = "x7y8z9"
      id = "claude-3-7-sonnet-20250219"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "created_at": "2025-02-19T00:00:00Z",
          "display_name": "Claude 3.7 Sonnet",
          "id": "#{id}",
          "type": "model"
        }
        JSON

      WebMock.stub(:GET, "https://api.anthropic.com/v1/models/#{id}")
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.models.fetch(id)

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::Model)
      response.should be_a(Lena::Model::Item)
    end
  end

  describe "#list" do
    it "lists models" do
      after_id = "id-123"
      api_key = "x7y8z9"
      request_id = "a1b2c3"

      body = <<-'JSON'
        {
          "data": [
            {
              "created_at": "2025-02-19T00:00:00Z",
              "display_name": "Claude 3.7 Sonnet",
              "id": "claude-3-7-sonnet-20250219",
              "type": "model"
            }
          ],
          "first_id": "<string>",
          "has_more": true,
          "last_id": "<string>"
        }
        JSON

      WebMock.stub(:GET, "https://api.anthropic.com/v1/models")
        .with(
          headers: {"X-API-Key" => api_key},
          query: {"after_id" => after_id}
        )
        .to_return(body: body, headers: {"request-id" => request_id})

      client = Lena.new(api_key)
      response = client.models.list(after_id: after_id)

      response.request_id.should eq(request_id)
      response.has_more.should be_true
      response.should be_a(Lena::Model::List)
    end
  end
end
