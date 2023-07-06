# frozen_string_literal: true

require "coveralls"
Coveralls.wear!

require "webmock/rspec"
require "vcr"

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "turkish_id"

VCR.configure do |c|
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.allow_http_connections_when_no_cassette = true
end
