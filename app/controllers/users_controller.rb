class UsersController < ActionController::API


	def create
		# if User.create(user_params)
		# 	render json: {status: 200, msg: 'User was created'}
		# else
		# 	render json: {status: 401, msg: 'User was not created'}
		# end
		debugger
		@user = User.new(user_params)
    if @user.save
    	render json: {status: 200, msg: 'User was created'}
    else
      render json: {status: 401, msg: @user.errors.full_messages}
    end
	end

	def signin
		
		@user = find_by(email: params[:email])
    if @user && @user.authenticate(password)
			render json: {status: 200, msg: 'Logged In'}
		else
			render json: {status: 401, msg: 'User Not Found'}
		end

		

		# response = DigitalTownService.new.loginUser(params.slice!(:email, :password))
    # if response[:status] == 404
    #   render json: response, status: 404
    # else
    #   user = User.find_by_email(params[:email])
  		# render json: response.merge!(community_membership_id: user.id)
    # end
	end

	private

	def user_params
    	params[:user].permit(:email, :password_digest, :username, :password)
  	end
end
