# frozen_string_literal: true

require 'net/http'
require 'json'

# Class: GetUserEvents
# A utility class used to retrieve user events from the Events Service.
# The class retrieves the event information based on user ID param.
#
# If request fails (HTTP status code other than 2xx), method returns an error
# message string containing the response code and message.
#
# Success Example:
#   GetUserEvents.new(1).call
#   >>: {:meeting_count=>3,
#        :next_meeting=>
#                       {:id=>4,
#                        :name=>"1on1",
#                        :duration=>60,
#                        :date=>Thu, 27 Jul 2023,
#                        :attendees=>2
#                        }
#       }
#
# Failure Example:
#   GetUserEvents.new(10).call
#   >>: {:error_code=> 404, :message=> "Not Found"}
#

class GetUserEvents
  EVENT_SERVICE = 'http://calendar-service:8000/events?user_id='

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    return @response if @response

    uri = URI("#{EVENT_SERVICE}#{@user_id}")
    @events = Net::HTTP.get_response(uri)

    @response = if @events.is_a?(Net::HTTPSuccess)
                  response
                else
                  errors
                end
  end

  private

  def errors
    if @events.code == 404
      {}
    else
      { error_code: @events.code,
        message: @events.message }.transform_keys(&:to_sym)
    end
  end

  def response
    @events = format_response_body
    format_dates
    generate_response
  end

  def generate_response
    { meeting_count: count_meetings, next_meeting: next_event }.transform_keys(&:to_sym)
  end

  def count_meetings
    @events.select { |event| event[:date] >= 1.week.ago.to_date && event[:date] <= Date.today }.size
  end

  def next_event
    @events.select { |event| event[:date] >= Date.today }.min_by { |event| event[:date] }
  end

  def format_dates
    @events.each { |event| event[:date] = Date.strptime(event[:date], '%m/%d/%Y') }
  end

  def format_response_body
    JSON.parse(@events.body, symbolize_names: true).fetch(:events, [])
  end
end
