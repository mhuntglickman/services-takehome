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
#   GetUserMetrics.new(1).call
#   >>:{:user_info=>
#                 {:id=>1, :first_name=>"Michael", :last_name=>"Scott"},
#       :subscription=>
#                 {:cost=>15.0, :days_to_renew=>30},
#       :events=>
#                 {:meeting_count=>3,
#                  :next_meeting=>
#                                 {:id=>4, :name=>"1on1", :duration=>60, :date=>Thu, 27 Jul 2023, :attendees=>2}
#                 }
#     }
#
# Failure Example:
#   GetUserMetrics.new(10).call
#   >>: {:error_code=> 404, :message=> "Not Found"}
#
class GetUserMetrics
  def initialize(user_id)
    @user_id = user_id
  end

  def call
    user = GetUserInfo.new(@user_id).call
    return user if errors?(user)

    events = GetUserEvents.new(@user_id).call
    return events if errors?(events)

    subscription = GetUserSubscription.new(@user_id).call
    return subscription if errors?(subscription)

    response(events, subscription, user)
  end

  private

  def response(events, subscription, user)
    {
      user: user,
      subscription: subscription,
      events: events
    }
  end

  def errors?(response)
    response.key?(:error_code) ? true : false
  end
end
