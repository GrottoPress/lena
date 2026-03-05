struct Lena::User
  enum Role
    User
    Developer
    Billing
    Admin
    ClaudeCodeUser
    Managed
  end

  include Resource

  getter added_at : Time?
  getter email : String?
  getter id : String?
  getter name : String?
  getter role : Role?
end
