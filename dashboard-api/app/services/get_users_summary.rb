# frozen_string_literal: true

require 'net/http'
require 'json'

# Class: GetUsersSummary
# A utility class used to retrieve all users information and position titles
# from the User Service.
#
# If request fails (HTTP status code other than 2xx), method returns an error
# message string containing the response code and message.
#
# Success Example:
#   @users = GetUsersSummary.new.call
#   >>: { "users":
#             [
#               {"first_name":"Michael","last_name":"Scott","position":"Regional Manager"},
#               {"first_name":"Jim","last_name":"Halpert","position":"Salesperson"}
#              ]
#        }
# Failure Example:
#   @users = GetUsersSummary.new(1).call
#   >>: {:error_code=> 404, :message=> "Not Found"}
#
#
class GetUsersSummary
  USER_SERVICE = 'http://user-service:8000/users/summary/'.freeze

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    return @response if @response

    uri = URI("#{USER_SERVICE}#{@user_id}")
    @users = Net::HTTP.get_response(uri)
    @response = if @users.is_a?(Net::HTTPSuccess)
                  format_response
                else
                  errors
                end
  end

  private

  def errors
    { error_code: @users.code.to_i,
      message: @users.message }.transform_keys(&:to_sym)
  end

  def format_response
    @users = JSON.parse(@users.body, symbolize_names: true)
  end
end
