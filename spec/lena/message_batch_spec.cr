require "../spec_helper"

describe Lena::MessageBatch::Endpoint do
  describe "#create" do
    it "creates message batch" do
      api_key = "x7y8z9"
      organization_id = "a1b2c3"
      request_id = "req_123"

      body = <<-'JSON'
        {
          "id": "msgbatch_013Zva2CMHLNnXvNJPErV5x8",
          "type": "message_batch",
          "processing_status": "in_progress",
          "request_counts": {
            "processing": 10,
            "succeeded": 0,
            "errored": 0,
            "canceled": 0,
            "expired": 0
          },
          "ended_at": null,
          "created_at": "2024-09-24T13:52:20.000Z",
          "expires_at": "2024-09-25T13:52:20.000Z",
          "archived_at": null,
          "results_url": null
        }
        JSON

      WebMock.stub(:POST, "https://api.anthropic.com/v1/messages/batches")
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {
            "anthropic-organization-id" => organization_id,
            "request-id" => request_id
          }
        )

      client = Lena.new(api_key)

      response = client.message_batches.create(
        requests: [
          {
            custom_id: "request-1",
            params: {
              model: "claude-3-haiku-20240307",
              max_tokens: 1024,
              messages: [{role: "user", content: "Hello, world"}]
            }
          }
        ]
      )

      response.organization_id.should eq(organization_id)
      response.request_id.should eq(request_id)

      response.should be_a(Lena::MessageBatch::Item)
      response.data.should be_a(Lena::MessageBatch)

      response.data.try do |data|
        data.id.should eq("msgbatch_013Zva2CMHLNnXvNJPErV5x8")

        data.processing_status
          .should(eq Lena::MessageBatch::ProcessingStatus::InProgress)
      end
    end
  end

  describe "#fetch" do
    it "retrieves message batch" do
      api_key = "x7y8z9"
      batch_id = "msgbatch_013Zva2CMHLNnXvNJPErV5x8"
      organization_id = "a1b2c3"
      results_url = "https://api.anthropic.com/v1/messages/batches/#{batch_id}/results"

      body = <<-JSON
        {
          "id": "#{batch_id}",
          "type": "message_batch",
          "processing_status": "ended",
          "request_counts": {
            "processing": 0,
            "succeeded": 10,
            "errored": 0,
            "canceled": 0,
            "expired": 0
          },
          "ended_at": "2024-09-24T13:55:20.000Z",
          "created_at": "2024-09-24T13:52:20.000Z",
          "expires_at": "2024-09-25T13:52:20.000Z",
          "archived_at": null,
          "results_url": "#{results_url}"
        }
        JSON

      WebMock.stub(
        :GET,
        "https://api.anthropic.com/v1/messages/batches/#{batch_id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.message_batches.fetch(batch_id)

      response.organization_id.should eq(organization_id)

      response.should be_a(Lena::MessageBatch::Item)
      response.data.should be_a(Lena::MessageBatch)

      response.data.try do |data|
        data.id.should eq(batch_id)
        data.processing_status.try(&.ended?).should be_true
        data.results_url.should eq(results_url)
      end
    end
  end

  describe "#list" do
    it "lists message batches" do
      api_key = "x7y8z9"
      organization_id = "a1b2c3"

      body = <<-'JSON'
        {
          "data": [
            {
              "id": "msgbatch_013Zva2CMHLNnXvNJPErV5x8",
              "type": "message_batch",
              "processing_status": "ended",
              "request_counts": {
                "processing": 0,
                "succeeded": 10,
                "errored": 0,
                "canceled": 0,
                "expired": 0
              },
              "ended_at": "2024-09-24T13:55:20.000Z",
              "created_at": "2024-09-24T13:52:20.000Z",
              "expires_at": "2024-09-25T13:52:20.000Z",
              "results_url": "https://api.anthropic.com/v1/messages/batches/msgbatch_013Zva2CMHLNnXvNJPErV5x8/results"
            }
          ],
          "has_more": false,
          "first_id": "msgbatch_013Zva2CMHLNnXvNJPErV5x8",
          "last_id": "msgbatch_013Zva2CMHLNnXvNJPErV5x8"
        }
        JSON

      WebMock.stub(:GET, "https://api.anthropic.com/v1/messages/batches")
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.message_batches.list

      response.organization_id.should eq(organization_id)

      response.should be_a(Lena::MessageBatch::List)
      response.data.should be_a(Array(Lena::MessageBatch))

      response.data.try(&.size).should eq(1)
      response.has_more?.should be_false
    end
  end

  describe "#cancel" do
    it "cancels message batch" do
      api_key = "x7y8z9"
      batch_id = "msgbatch_013Zva2CMHLNnXvNJPErV5x8"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "#{batch_id}",
          "type": "message_batch",
          "processing_status": "canceling",
          "request_counts": {
            "processing": 5,
            "succeeded": 3,
            "errored": 0,
            "canceled": 2,
            "expired": 0
          },
          "ended_at": null,
          "created_at": "2024-09-24T13:52:20.000Z",
          "expires_at": "2024-09-25T13:52:20.000Z",
          "archived_at": null,
          "results_url": null
        }
        JSON

      WebMock.stub(
        :POST,
        "https://api.anthropic.com/v1/messages/batches/#{batch_id}/cancel"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.message_batches.cancel(batch_id)

      response.organization_id.should eq(organization_id)

      response.should be_a(Lena::MessageBatch::Item)
      response.data.should be_a(Lena::MessageBatch)

      response.data.try do |data|
        data.id.should eq(batch_id)
        data.processing_status.try(&.canceling?).should be_true
      end
    end
  end

  describe "#delete" do
    it "deletes message batch" do
      api_key = "x7y8z9"
      batch_id = "msgbatch_013Zva2CMHLNnXvNJPErV5x8"
      organization_id = "a1b2c3"

      body = <<-JSON
        {
          "id": "#{batch_id}",
          "type": "message_batch",
          "processing_status": "ended",
          "request_counts": {
            "processing": 0,
            "succeeded": 10,
            "errored": 0,
            "canceled": 0,
            "expired": 0
          },
          "ended_at": "2024-09-24T13:55:20.000Z",
          "created_at": "2024-09-24T13:52:20.000Z",
          "expires_at": "2024-09-25T13:52:20.000Z",
          "archived_at": "2024-09-24T14:00:00.000Z",
          "results_url": null
        }
        JSON

      WebMock.stub(
        :DELETE,
        "https://api.anthropic.com/v1/messages/batches/#{batch_id}"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.message_batches.delete(batch_id)

      response.organization_id.should eq(organization_id)

      response.should be_a(Lena::MessageBatch::Item)
      response.data.should be_a(Lena::MessageBatch)

      response.data.try do |data|
        data.id.should eq(batch_id)
        data.archived_at.should_not be_nil
      end
    end
  end

  describe "#results" do
    it "retrieves message batch results" do
      api_key = "x7y8z9"
      batch_id = "msgbatch_013Zva2CMHLNnXvNJPErV5x8"
      organization_id = "a1b2c3"

      results_body = <<-'JSONL'
{"custom_id": "request-1", "result": {"type": "succeeded", "message": {"id": "msg_013Zva2CMHLNnXjNJJKqJ2EF", "content": [{"type": "text", "text": "Hello! How can I help you today?"}], "model": "claude-3-haiku-20240307", "role": "assistant", "stop_reason": "end_turn", "stop_sequence": null, "usage": {"input_tokens": 10, "output_tokens": 25}}}}
{"custom_id": "request-2", "result": {"type": "succeeded", "message": {"id": "msg_013Zva2CMHLNnXjNJJKqJ2EG", "content": [{"type": "text", "text": "I'm doing well, thank you!"}], "model": "claude-3-haiku-20240307", "role": "assistant", "stop_reason": "end_turn", "stop_sequence": null, "usage": {"input_tokens": 12, "output_tokens": 20}}}}
JSONL

      WebMock.stub(
        :GET,
        "https://api.anthropic.com/v1/messages/batches/#{batch_id}/results"
      )
        .with(headers: {"X-API-Key" => api_key})
        .to_return(
          body: results_body,
          headers: {"anthropic-organization-id" => organization_id}
        )

      client = Lena.new(api_key)
      response = client.message_batches.results(batch_id)

      response.organization_id.should eq(organization_id)

      response.should be_a(Lena::MessageBatch::Result::List)
      response.data.should be_a(Array(Lena::MessageBatch::Result))

      results_array = response.data.not_nil!
      results_array.size.should eq(2)

      # Test first result
      first_result = results_array[0]
      first_result.custom_id.should eq("request-1")
      first_result.type.should(eq Lena::MessageBatch::Result::Type::Succeeded)
      first_result.message.try(&.id).should(eq "msg_013Zva2CMHLNnXjNJJKqJ2EF")

      # Test second result
      second_result = results_array[1]
      second_result.custom_id.should eq("request-2")
      second_result.type.should(eq Lena::MessageBatch::Result::Type::Succeeded)
      second_result.message.try(&.id).should(eq "msg_013Zva2CMHLNnXjNJJKqJ2EG")
    end
  end

  it "handles error" do
    api_key = "x7y8z9"
    batch_id = "msgbatch_01J8J1K1M1N1O1P1Q1R1S1T1U1"
    organization_id = "d4e5f6"
    request_id = "a1b2c3"

    error_body = <<-'JSON'
      {
        "error": {
          "message": "Batch not found",
          "type": "not_found_error"
        },
        "type": "error"
      }
      JSON

    WebMock.stub(
      :GET,
      "https://api.anthropic.com/v1/messages/batches/#{batch_id}/results"
    )
      .with(headers: {"X-API-Key" => api_key})
      .to_return(body: error_body, headers: {
        "anthropic-organization-id" => organization_id,
        "request-id" => request_id
      })

    client = Lena.new(api_key)
    response = client.message_batches.results(batch_id)

    response.should be_a(Lena::MessageBatch::Result::List)
    response.type.try(&.error?).should be_true
    response.error.should be_a(Lena::Error)
    response.error.try(&.type.not_found_error?).should be_true
    response.error.try(&.message).should eq("Batch not found")
    response.data.should be_nil
    response.organization_id.should eq(organization_id)
    response.request_id.should eq(request_id)
  end
end
