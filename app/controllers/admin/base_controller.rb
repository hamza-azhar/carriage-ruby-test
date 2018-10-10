class Admin::BaseController < ApplicationController
	before_action :validate_token, :validate_admin


  def validate_admin
    @error_message = []
    if @current_user.present? && !current_user.is_admin?
      @error_message << "You do not have admin rights"
    end

    if @error_message.present?
      render(json: {ok: false, error: @error_message, status: 401}, status: 401) and return
    end
  end
end
