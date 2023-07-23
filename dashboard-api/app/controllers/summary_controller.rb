# frozen_string_literal: true
# Class: SummaryController
#
# Controller that handles requests for retrieving:
# 1) summary metrics for a user.
#
class SummaryController < ApplicationController
  def show
    metrics = GetUserMetrics.new(params[:user_id]).call
    render json: { message: metrics[:message] }, status: :not_found if metrics.key?(:error_code)
    render json: { data: metrics }, status: :ok unless performed?
  end
end
