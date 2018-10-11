class ApplicationController < ActionController::API
	#{}"ssss"

	protected
	def validate_token
		 @error_message = []
		if request.headers['Authorization'].present?
      if !request.headers['Authorization'].include?("Token ") || request.headers['Authorization'].split(" ").present? && !(request.headers['Authorization'].split(" ").count > 1)
        @error_message << "Invalid Authorization token"
      else  
        @current_user = User.find_by_access_token(request.headers['Authorization'].split(" ")[1])    
        if @current_user.blank?
          @error_message << "Invalid Authorization token"
        end
      end
    else
      @error_message << "Authorization header must be present."
    end

    if @error_message.present?
    	render(json: {ok: false, error: @error_message, status: 401}, status: 401) and return
    end
  end

  def validate_member
    @error_message = []
    if @current_user.present? && !@current_user.has_role?(:member)
      @error_message << "You do not have member rights"
    end

    if @error_message.present?
      render(json: {ok: false, error: @error_message, status: 401}, status: 401) and return
    end
  end
end
