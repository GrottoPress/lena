require "../spec_helper"

describe Lena::ApiKey::Endpoint do
  describe "#fetch" do
    it "gets api key" do
      api_key = "x7y8z9"
      id = "apikey_01Rj2N8SVvo6BePZj99NhmiT"
      organization_id = "a1b2c3"
      name = "Test Key"

      body = <<-JSON
        {
          "id": "#{id}",
          "name": "#{name}",
          "type": "api_key",
          "status": "active",
          "created_at": "2024-10-30T23:58:27.427722Z",
          "partial_key_hint": "sk-ant-api03-R2D...igAA",
          "workspace_id": "wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ",
          "created_by": {
            "id": "user_01WCz1FkmYMm4gnmykNKUu3Q",
            "type": "user"
          }
        }
        JSON

      WebMock.stub(
        :GET,
        "https://api.anthropic.com/v1/organizations/api_keys/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.api_keys.fetch(id)

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::ApiKey)
      response.data.should be_a(Lena::ApiKey)

      response.data.try do |data|
        data.id.should eq(id)
        data.name.should eq(name)
        data.status.should eq("active")
      end
    end
  end

  describe "#list" do
    it "lists api keys" do
      after_id = "apikey_01Rj2N8SVvo6BePZj99NhmiT"
      api_key = "x7y8z9"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "data": [
            {
              "id": "#{after_id}",
              "name": "Test Key",
              "type": "api_key",
              "status": "active",
              "created_at": "2024-10-30T23:58:27.427722Z",
              "partial_key_hint": "sk-ant-api03-R2D...igAA"
            }
          ],
          "first_id": "#{after_id}",
          "has_more": false,
          "last_id": "#{after_id}"
        }
        JSON

      WebMock.stub(:GET, "https://api.anthropic.com/v1/organizations/api_keys")
        .with(
          headers: {"X-API-Key" => api_key},
          query: {"after_id" => after_id}
        )
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.api_keys.list(after_id: after_id)

      response.organization_id.should eq(organization_id)
      response.has_more?.should be_false
      response.data.should be_a(Array(Lena::ApiKey))
    end
  end

  describe "#update" do
    it "updates api key" do
      api_key = "x7y8z9"
      id = "apikey_01Rj2N8SVvo6BePZj99NhmiT"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "#{id}",
          "name": "Updated Key",
          "type": "api_key",
          "status": "inactive",
          "created_at": "2024-10-30T23:58:27.427722Z",
          "partial_key_hint": "sk-ant-api03-R2D...igAA"
        }
        JSON

      WebMock.stub(
        :POST,
        "https://api.anthropic.com/v1/organizations/api_keys/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.api_keys.update(id, name: "Updated Key", status: "inactive")

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::ApiKey)
      response.data.should be_a(Lena::ApiKey)

      response.data.try do |data|
        data.name.should eq("Updated Key")
        data.status.should eq("inactive")
      end
    end
  end
end
