# frozen_string_literal: true

# Class: UserController
# A controller to handle user-related requests.
#
# Methods:
#   - show: Retrieves and renders user information based on the provided user_id.
#   - summary: Retrieves and renders a summary of all users' details for admin users.
#
class UserController < ApplicationController
  USERS = [
    { 'id' => 1, 'first_name' => 'Michael', 'last_name' => 'Scott', 'position' => 'Regional Manager',
      'role' => 'admin' },
    { 'id' => 2, 'first_name' => 'Jim', 'last_name' => 'Halpert', 'position' => 'Salesperson', 'role' => 'user' },
    { 'id' => 3, 'first_name' => 'Pam', 'last_name' => 'Beesly', 'position' => 'Receptionist', 'role' => 'user' },
    { 'id' => 4, 'first_name' => 'Dwight', 'last_name' => 'Schrute', 'position' => 'Salesperson', 'role' => 'user' },
    { 'id' => 5, 'first_name' => 'Anglea', 'last_name' => 'Martin', 'position' => 'Accountant', 'role' => 'user' }
  ].freeze

  # Route:
  #   GET 'users/:user_id'
  #
  # Parameters:
  #   - user_id: Integer, unique identifier for the user to retrieve.


  def show
    user_id = params[:user_id].to_i

    user = USERS.find { |x| x['id'] == user_id }

    if user
      render json: { id: user['id'], first_name: user['first_name'], last_name: user['last_name'] }
    else
      render json: { message: 'User not found' }, status: :not_found
    end
  end

  # Route:
  #   GET 'users/summary'
  #
  # Parameters:
  #   - user_id: Integer, unique identifier for the user; user is checked for admin role.

  def summary
    user_id = params[:user_id].to_i

    user = USERS.find { |x| x['id'] == user_id }
    if user['role'] == 'admin'
      users = USERS.map do |user|
        { first_name: user['first_name'], last_name: user['last_name'], position: user['position'] }
      end
      render json: { users: users }, status: :ok
    end
    render json: { message: 'Unauthorized' }, status: :unauthorized unless performed?
  end
end
