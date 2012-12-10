require "rubygems"
require 'bundler/setup'

require './helpers'

["slim", "grape"].each{ |library| require library }

class SlimConvert < Grape::API

  version         'v1', :using => :path

  default_format  :json
  format          :json

  helpers SlimConvertable

  post '/slim/convert' do
    begin
      source = params[:source]
      {:success => true, :result => convert(source)}
    rescue => e
      {:success => false, :error => e.message}
    end
  end

end 

