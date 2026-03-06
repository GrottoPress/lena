require "../spec_helper"

describe Lena::Workspace::Endpoint do
  describe "#fetch" do
    it "gets workspace" do
      api_key = "x7y8z9"
      id = "wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ"
      organization_id = "a1b2c3"
      name = "Test Workspace"

      body = <<-JSON
        {
          "id": "#{id}",
          "name": "#{name}",
          "type": "workspace",
          "created_at": "2024-10-30T23:58:27.427722Z"
        }
        JSON

      WebMock.stub(
        :GET,
        "https://api.anthropic.com/v1/organizations/workspaces/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.workspaces.fetch(id)

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::Workspace)
      response.data.should be_a(Lena::Workspace)

      response.data.try do |data|
        data.id.should eq(id)
        data.name.should eq(name)
      end
    end
  end

  describe "#list" do
    it "lists workspaces" do
      after_id = "wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ"
      api_key = "x7y8z9"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "data": [
            {
              "id": "#{after_id}",
              "name": "Test Workspace",
              "type": "workspace",
              "created_at": "2024-10-30T23:58:27.427722Z"
            }
          ],
          "first_id": "#{after_id}",
          "has_more": false,
          "last_id": "#{after_id}"
        }
        JSON

      WebMock.stub(:GET, "https://api.anthropic.com/v1/organizations/workspaces")
        .with(
          headers: {"X-API-Key" => api_key},
          query: {"after_id" => after_id}
        )
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.workspaces.list(after_id: after_id)

      response.organization_id.should eq(organization_id)
      response.has_more?.should be_false
      response.data.should be_a(Array(Lena::Workspace))
    end
  end

  describe "#create" do
    it "creates workspace" do
      api_key = "x7y8z9"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ",
          "name": "Test Workspace",
          "type": "workspace",
          "created_at": "2024-10-30T23:58:27.427722Z"
        }
        JSON

      WebMock.stub(:POST, "https://api.anthropic.com/v1/organizations/workspaces")
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.workspaces.create(name: "Test Workspace")

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::Workspace)
      response.data.should be_a(Lena::Workspace)
    end
  end

  describe "#update" do
    it "updates workspace" do
      api_key = "x7y8z9"
      id = "wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "#{id}",
          "name": "Updated Workspace",
          "type": "workspace",
          "created_at": "2024-10-30T23:58:27.427722Z"
        }
        JSON

      WebMock.stub(
        :POST,
        "https://api.anthropic.com/v1/organizations/workspaces/#{id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.workspaces.update(id, name: "Updated Workspace")

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::Workspace)
      response.data.should be_a(Lena::Workspace)

      response.data.try do |data|
        data.name.should eq("Updated Workspace")
      end
    end
  end

  describe "#archive" do
    it "archives workspace" do
      api_key = "x7y8z9"
      id = "wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "#{id}",
          "name": "Test Workspace",
          "type": "workspace",
          "created_at": "2024-10-30T23:58:27.427722Z",
          "archived_at": "2024-11-01T23:59:27.427722Z"
        }
        JSON

      WebMock.stub(
        :POST,
        "https://api.anthropic.com/v1/organizations/workspaces/#{id}/archive"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.workspaces.archive(id)

      response.organization_id.should eq(organization_id)
      response.type.should eq(Lena::Response::Type::Workspace)
      response.data.should be_a(Lena::Workspace)

      response.data.try do |data|
        data.id.should eq(id)
      end
    end
  end
end
