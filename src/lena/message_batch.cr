struct Lena::MessageBatch
  include Resource

  getter archived_at : Time?
  getter cancel_initiated_at : Time?
  getter created_at : Time?
  getter ended_at : Time?
  getter expires_at : Time?
  getter id : String?
  getter processing_status : ProcessingStatus?
  getter request_counts : RequestCounts?
  getter results_url : String?
end
