require "../spec_helper"

describe Lena::Invite::Endpoint do
  describe "#fetch" do
    it "gets invite" do
      api_key = "x7y8z9"
      id = "invite-123456"
      organization_id = "a1b2c3"
      email = "test@example.com"

      body = <<-JSON
        {
          "id": "#{id}",
          "email": "#{email}",
          "type": "invite"
        }
        JSON

      WebMock.stub(
        :GET,
        "https://api.anthropic.com/v1/organizations/invites/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.invites.fetch(id)

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::Invite)
      response.data.should be_a(Lena::Invite)

      response.data.try do |data|
        data.id.should eq(id)
        data.email.should eq(email)
      end
    end
  end

  describe "#list" do
    it "lists invite" do
      after_id = "id-123"
      api_key = "x7y8z9"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "data": [
            {
              "id": "invite-123456",
              "email": "test@example.com",
              "type": "invite"
            }
          ],
          "first_id": "invite-123",
          "has_more": false,
          "last_id": "invite-789"
        }
        JSON

      WebMock.stub(:GET, "https://api.anthropic.com/v1/organizations/invites")
        .with(
          headers: {"X-API-Key" => api_key},
          query: {"after_id" => after_id}
        )
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.invites.list(after_id: after_id)

      response.organization_id.should eq(organization_id)
      response.has_more?.should be_false
      response.data.should be_a(Array(Lena::Invite))
    end
  end

  describe "#create" do
    it "creates invite" do
      api_key = "x7y8z9"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "invite-123456",
          "email": "test@example.com",
          "type": "invite"
        }
        JSON

      WebMock.stub(:POST, "https://api.anthropic.com/v1/organizations/invites")
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.invites.create(role: "developer")

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::Invite)
      response.data.should be_a(Lena::Invite)
    end
  end

  describe "#delete" do
    it "deletes invite" do
      api_key = "x7y8z9"
      id = "invite-123456"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "#{id}",
          "type": "invite_deleted"
        }
        JSON

      WebMock.stub(
        :DELETE,
        "https://api.anthropic.com/v1/organizations/invites/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.invites.delete(id)

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::InviteDeleted)
      response.data.should be_a(Lena::Invite)

      response.data.try do |data|
        data.id.should eq(id)
      end
    end
  end
end
