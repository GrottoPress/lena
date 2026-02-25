struct Lena::MessageBatch::Result::List
  include Response

  getter data : Array(Result)?

  private def initialize(jsonl : String)
    @data = jsonl.lines.map do |line|
      Result.from_json(line.strip)
    end
  end

  def self.from_jsonl(response : HTTP::Client::Response) : self
    from_jsonl(response.body).set_additional_properties(response)
  end

  def self.from_jsonl(jsonl : String) : self
    new(jsonl)
  rescue JSON::ParseException
    from_json(jsonl)
  end
end
