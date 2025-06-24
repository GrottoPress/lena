class Lena::MessageBatch::Result::Item
  include Response

  getter results : Array(Lena::MessageBatch::Result)?

  def initialize(jsonl : String)
    @results = jsonl.lines.map do |line|
      Lena::MessageBatch::Result.from_json(line.strip)
    end
  end

  def self.from_jsonl(jsonl : String) : self
    new(jsonl)
  rescue JSON::ParseException
    from_json(jsonl)
  end
end
