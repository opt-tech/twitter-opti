class AjaxTestController < ApplicationController
  layout 'ajax'
  require 'net/http'

  def index
  end

  def data
    url = URI('http://queryfeed.net/twitter?q=%23%E3%83%80%E3%83%B3%E3%83%A1%E3%83%A2&title-type=user-name-both&geocode=')
    http = Net::HTTP.new(url.host)
    response = http.get(url)
    @data = Hash.from_xml(response.body).to_json.html_safe
  end
end
