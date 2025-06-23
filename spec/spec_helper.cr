require "spec"
require "webmock"
require "../src/lena"

Spec.before_each do
  WebMock.reset
end
