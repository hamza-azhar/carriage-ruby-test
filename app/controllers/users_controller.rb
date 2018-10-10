class UsersController < ApplicationController
	before_action :validate_token, only: :get_all_users
  
  def new
    @user = User.new
  end

  def create
    @user = User.new({username: params[:username], email: params[:email], password: params[:password]})
    @user.email.downcase!
    
    if @user.save
      # If user saves in the db successfully:
      render json: {status: 200, msg: 'User was created'}
    else
      # If user fails model validation - probably a bad password or duplicate email:
      render json: {status: 401, msg: @user.errors.full_messages}
    end
  end

  def signin
		@user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) && @user.update(access_token: @user.generate_token)
			render json: {status: 200, msg: 'Logged In', token: @user.access_token}
		else
			render json: {status: 401, msg: 'User Not Found'}
		end
	end

	def get_all_users
		@users = User.all
		render json: {status: 200, users: @users}
	end
end


