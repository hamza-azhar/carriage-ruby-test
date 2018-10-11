class ListsController < ApplicationController
	before_action :validate_token
	before_action :validate_member
	before_action :set_list, only: [:show, :update, :destroy]
	def index
		@lists = @current_user.lists
		render "index.json"
	end

	def show
		if @list.present?
			render "show.json"
		else
			render(json: {success: false, message: "List not found"}, status: 200)
		end
	end

	private
	def list_params
		params[:list].permit(:title)
	end

	def set_list
		@list = @current_user.lists.find_by(id: params[:id])
	end
end
