require "../spec_helper"

describe Lena::User::Endpoint do
  describe "#fetch" do
    it "gets user" do
      api_key = "x7y8z9"
      id = "user-123456"
      organization_id = "a1b2c3"
      email = "test@example.com"
      name = "Test User"

      body = <<-JSON
        {
          "id": "#{id}",
          "email": "#{email}",
          "name": "#{name}",
          "type": "user"
        }
        JSON

      WebMock.stub(
        :GET,
        "https://api.anthropic.com/v1/organizations/users/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.users.fetch(id)

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::User)
      response.data.should be_a(Lena::User)

      response.data.try do |data|
        data.id.should eq(id)
        data.email.should eq(email)
        data.name.should eq(name)
      end
    end
  end

  describe "#list" do
    it "lists user" do
      after_id = "id-123"
      api_key = "x7y8z9"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "data": [
            {
              "id": "user-123456",
              "email": "test@example.com",
              "name": "Test User",
              "type": "user"
            }
          ],
          "first_id": "user-123",
          "has_more": false,
          "last_id": "user-789"
        }
        JSON

      WebMock.stub(:GET, "https://api.anthropic.com/v1/organizations/users")
        .with(
          headers: {"X-API-Key" => api_key},
          query: {"after_id" => after_id}
        )
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.users.list(after_id: after_id)

      response.organization_id.should eq(organization_id)
      response.has_more?.should be_false
      response.data.should be_a(Array(Lena::User))
    end
  end

  describe "#update" do
    it "updates user" do
      api_key = "x7y8z9"
      id = "user-123456"
      organization_id = "a1b2c3"
      name = "Test User"

      body = <<-JSON
        {
          "id": "#{id}",
          "email": "test@example.com",
          "name": "#{name}",
          "type": "user"
        }
        JSON

      WebMock.stub(
        :POST,
        "https://api.anthropic.com/v1/organizations/users/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.users.update(id, role: "user")

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::User)
      response.data.should be_a(Lena::User)

      response.data.try do |data|
        data.id.should eq(id)
        data.name.should eq(name)
      end
    end
  end

  describe "#delete" do
    it "deletes user" do
      api_key = "x7y8z9"
      id = "user-123456"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "#{id}",
          "type": "user_deleted"
        }
        JSON

      WebMock.stub(
        :DELETE,
        "https://api.anthropic.com/v1/organizations/users/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.users.delete(id)

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::UserDeleted)
      response.data.should be_a(Lena::User)

      response.data.try do |data|
        data.id.should eq(id)
      end
    end
  end
end
