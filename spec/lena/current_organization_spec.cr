require "../spec_helper"

describe Lena::CurrentOrganization::Endpoint do
  describe "#fetch" do
    it "gets current organization" do
      api_key = "x7y8z9"
      id = "org-123456"
      organization_id = "a1b2c3"
      name = "Test Organization"

      body = <<-JSON
        {
          "id": "#{id}",
          "name": "#{name}",
          "type": "organization"
        }
        JSON

      WebMock.stub(:GET, "https://api.anthropic.com/v1/organizations/me")
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.current_organization.fetch

      response.organization_id.should eq(organization_id)
      response.type.try(&.organization?).should be_true
      response.data.should be_a(Lena::Organization)

      response.data.try do |data|
        data.id.should eq(id)
        data.name.should eq(name)
      end
    end
  end
end
