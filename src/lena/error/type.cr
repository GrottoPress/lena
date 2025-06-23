enum Lena::Error::Type
  InvalidRequestError = 400
  AuthenticationError = 401
  PermissionError = 403
  NotFoundError = 404
  RequestTooLarge = 413
  RateLimitError = 429
  ApiError = 500
  TimeoutError = 504
  OverloadedError = 529

  BillingError
end
