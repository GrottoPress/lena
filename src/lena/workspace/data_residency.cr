struct Lena::Workspace::DataResidency
  include Resource

  getter allowed_inference_geos : Array(String)
  getter default_inference_geo : String
  getter workspace_geo : String
end
