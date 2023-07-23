# frozen_string_literal: true

require 'net/http'
require 'json'

# Class: GetUserSubscription
# A utility class used to retrieve user subscription from the Billing Service.
# The class retrieves the event information based on user ID param.
#
# If request fails (HTTP status code other than 2xx), method returns an error
# message string containing the response code and message.
#
# Success Example:
#   GetUserSubscription.new(1).call
#   >>: {:cost=>15.0, :days_to_renew=>30}
#
# Failure Example:
#   GetUserSubscription.new(10).call
#   >>: {:error_code=> 404, :message=> "Not Found"}
#
class GetUserSubscription
  BILLING_SERVICE = 'http://billing-service:8000/subscriptions?user_id='

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    return @response if @response

    uri = URI("#{BILLING_SERVICE}#{@user_id}")
    @subscription = Net::HTTP.get_response(uri)

    @response = if @subscription.is_a?(Net::HTTPSuccess)
                  response
                else
                  errors
                end
  end

  private

  def errors
    if @subscription.code == 404
      {}
    else
      { error_code: @subscription.code,
        message: @subscription.message }.transform_keys(&:to_sym)
    end
  end

  def response
    @subscription = format_response_body
    generate_response
  end

  def subscription_cost
    @subscription[:price_cents] / 100.0
  end

  def renew_date
    Date.strptime(@subscription[:renewal_date], '%m/%d/%Y')
  end

  def days_to_renew
    (renew_date - Date.today).to_i
  end

  def format_response_body
    JSON.parse(@subscription.body, symbolize_names: true)
  end

  def generate_response
    { cost: subscription_cost, days_to_renew: days_to_renew }.transform_keys(&:to_sym)
  end
end
