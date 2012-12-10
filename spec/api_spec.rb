require 'minitest/spec'
require 'minitest/autorun'
require 'multi_json'
require 'rest_client'
require 'slim'

require File.expand_path(File.join(File.dirname(__FILE__),"..", "helpers"))

def slim_source(slim_name)
  path = File.expand_path(File.join(File.dirname(__FILE__),"fixtures", "#{slim_name}.slim"))
  fixture = File.open(path).read
  return fixture
end

describe "SlimConvertApi" do
  include SlimConvertable

  let(:api_uri){ 'http://localhost:9292/v1'}
  let(:source){ slim_source("test") }
  let(:invalid_source){ slim_source("invalid") }

  it "converts slim source to html" do
    html_fixtures_result = convert(source)

    result = RestClient.post "#{api_uri}/slim/convert", :source => source
    result_encoded = MultiJson.load(result)
    result_encoded.has_key?("result").must_equal true
    result_encoded.has_key?("success").must_equal true
    result_encoded["result"].must_equal html_fixtures_result

    #äpath = File.expand_path(File.join(File.dirname(__FILE__),"fixtures", "test.html"))
    #File.open(path, 'w'){ |file| file.write(result_encoded["result"]) }
  end

  it "returns an error if slim converting fails" do
    result = RestClient.post "#{api_uri}/slim/convert", :source => invalid_source
    result_encoded = MultiJson.load(result)
    result_encoded.has_key?("success").must_equal true
    result_encoded["success"].must_equal false
    result_encoded["error"].wont_be_empty
    result_encoded["error"].must_include "Malformed indentation"
  end
end