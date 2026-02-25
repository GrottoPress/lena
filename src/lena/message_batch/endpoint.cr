struct Lena::MessageBatch::Endpoint
  include Lena::Endpoint

  def initialize(@client : Lena)
  end

  def create(headers = nil, **params) : Item
    response = @client.post(uri.path, headers, params.to_json)
    Item.from_json(response)
  end

  def fetch(id : String, headers = nil) : Item
    path = "#{uri.path}/#{id}"
    response = @client.get(path, headers)

    Item.from_json(response)
  end

  def list(headers = nil, **params) : List
    response = @client.get(uri.path, headers)
    List.from_json(response)
  end

  def cancel(id : String, headers = nil) : Item
    path = "#{uri.path}/#{id}/cancel"
    response = @client.post(path, headers)

    Item.from_json(response)
  end

  def delete(id : String, headers = nil) : Item
    path = "#{uri.path}/#{id}"
    response = @client.delete(path, headers)

    Item.from_json(response)
  end

  def results(id : String, headers = nil) : Result::List
    path = "#{uri.path}/#{id}/results"
    response = @client.get(path, headers)

    Result::List.from_jsonl(response)
  end

  getter uri : URI do
    URI.parse(@client.messages.uri.to_s).tap { |uri| uri.path += "/batches" }
  end
end
