# frozen_string_literal: true
# Class: SummaryController
#
# Methods:
#   - show: Retrieves and renders key metrics for a user.  When that user is an ADMIN this includes a
#
class SummaryController < ApplicationController
  def show
    metrics = GetUserMetrics.new(params[:user_id].to_i).call
    render json: { message: metrics[:message] }, status: :not_found if metrics.key?(:error_code)
    render json: { summary: metrics }, status: :ok unless performed?
  end
end
