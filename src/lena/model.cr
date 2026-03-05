struct Lena::Model
  include Resource

  OPUS_4_6 = "claude-opus-4-6"
  OPUS_4_5 = "claude-opus-4-5"
  OPUS_4_5_20251101 = "claude-opus-4-5-20251101"
  OPUS_4_1 = "claude-opus-4-1"
  OPUS_4_1_20250805 = "claude-opus-4-1-20250805"
  OPUS_4_0 = "claude-opus-4-0"
  OPUS_4_0_20250514 = "claude-opus-4-20250514"

  SONNET_4_6 = "claude-sonnet-4-6"
  SONNET_4_5 = "claude-sonnet-4-5"
  SONNET_4_5_20250929 = "claude-sonnet-4-5-20250929"
  SONNET_4_0 = "claude-sonnet-4-0"
  SONNET_4_0_20250514 = "claude-sonnet-4-20250514"

  HAIKU_4_5 = "claude-haiku-4-5"
  HAIKU_4_5_20251001 = "claude-haiku-4-5-20251001"
  HAIKU_3_0_20240307 = "claude-3-haiku-20240307"

  getter created_at : Time?
  getter display_name : String?
  getter id : String?
end
