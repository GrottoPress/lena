struct Lena::MessageBatch::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  def create(headers = nil, **params) : Item
    response = @client.post(self.class.uri.path, headers, params.to_json)
    Item.from_json(response.body).set_additional_properties(response)
  end

  def fetch(id : String, headers = nil) : Item
    path = "#{self.class.uri.path}/#{id}"
    response = @client.get(path, headers)

    Item.from_json(response.body).set_additional_properties(response)
  end

  def list(headers = nil, **params) : List
    response = @client.get(self.class.uri.path, headers)
    List.from_json(response.body).set_additional_properties(response)
  end

  def cancel(id : String, headers = nil) : Item
    path = "#{self.class.uri.path}/#{id}/cancel"
    response = @client.post(path, headers)

    Item.from_json(response.body).set_additional_properties(response)
  end

  def delete(id : String, headers = nil) : Item
    path = "#{self.class.uri.path}/#{id}"
    response = @client.delete(path, headers)

    Item.from_json(response.body).set_additional_properties(response)
  end

  def results(id : String, headers = nil) : Result::Item
    path = "#{self.class.uri.path}/#{id}/results"
    response = @client.get(path, headers)

    Result::Item.from_jsonl(response.body).set_additional_properties(response)
  end

  def self.uri : URI
    Message::Endpoint.uri.tap { |uri| uri.path += "/batches" }
  end
end
