struct Lena::Message::Citation
  enum Type
    CharLocation
    PageLocation
    ContentBlockLocation
    WebSearchResultLocation
    SearchResultLocation
  end

  include Resource

  getter cited_text : String?
  getter document_index : Int32?
  getter document_title : String?
  getter encrypted_index : String?
  getter end_block_index : Int32?
  getter end_char_index : Int32?
  getter end_page_number : Int32?
  getter file_id : String?
  getter search_result_index : Int32?
  getter source : String?
  getter start_block_index : Int32?
  getter start_char_index : Int32?
  getter start_page_number : Int32?
  getter title : String?
  getter type : Type
  getter url : String?
end
