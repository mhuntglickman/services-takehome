# frozen_string_literal: true

require 'net/http'
require 'json'

# Class: GetUserInfo
# A utility class used to retrieve user information from the User Service.
# The class retrieves the user information based on user ID param.
#
# If request fails (HTTP status code other than 2xx), method returns an error
# message string containing the response code and message.
#
# Success Example:
#   GetUserInfo.new(1).call
#   >>: {:id=>1, :first_name=>"Michael", :last_name=>"Scott"}
#
# Failure Example:
#   GetUserInfo.new(10).call
#   >>: {:error_code=> 404, :message=> "Not Found"}
#
class GetUserInfo
  USER_SERVICE = 'http://user-service:8000/users/'

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    return @response if @response

    uri = URI("#{USER_SERVICE}#{@user_id}")
    @user = Net::HTTP.get_response(uri)
    @response = if @user.is_a?(Net::HTTPSuccess)
                  format_response
                  response
                else
                  errors
                end
  end

  private

  def errors
    { error_code: @user.code,
      message: @user.message }.transform_keys(&:to_sym)
  end

  def format_response
    @user = JSON.parse(@user.body, symbolize_names: true)
  end

  def response
    { full_name: "#{@user[:first_name]} #{@user[:last_name]}" }
  end
end
