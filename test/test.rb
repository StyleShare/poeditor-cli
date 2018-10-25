require "minitest/autorun"
require "webmock/minitest"

require "helper"
require_relative "../lib/poeditor"

class Test < Minitest::Test

  def stub_api(request_action, request_body_include=nil, response_body)
    request_body_include = request_body_include || {}
    stub_request(:post, "https://api.poeditor.com/v2/#{request_action}")
      .with(:body => hash_including(request_body_include))
      .to_return(:body => response_body)
  end

  def stub_api_export(language, body)
    stub_api "projects/export", {"language" => language}, <<~BODY
      {
        "response": {
          "status": "success",
          "code": "200",
          "message": "OK"
        },
        "result": {
          "url": "https://poeditor.com/api/download/file/#{language}"
        }
      }
    BODY
    stub_request(:get, "https://poeditor.com/api/download/file/#{language}")
      .to_return(body: body)
  end

  def stub_api_export_failure
    stub_api "export", <<~BODY
      {
        "response": {
          "status": "fail",
          "code": "4011",
          "message": "Invalid API Token"
        }
      }
    BODY
  end

end
