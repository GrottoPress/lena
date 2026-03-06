struct Lena::Invite
  enum Status
    Accepted
    Expired
    Deleted
    Pending
  end

  include Resource

  getter email : String?
  getter expires_at : Time?
  getter id : String?
  getter invited_at : Time?
  getter role : User::Role?
  getter status : Status?
end
