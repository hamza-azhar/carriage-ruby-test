class Admin::ListsController < Admin::BaseController
	before_action :set_list, only: [:show, :update_list, :destroy_list]

	def index
		@lists = List.all
		render(json: { success: true, results: @lists }, status: 200)
	end

	def create
		@list = @current_user.lists.new(list_params)
		@list.list_users.build(user_id: @current_user.id, is_creator: true)
		if @list.save!
			render(json: {success: true, message: 'List added successfully'}, status: 200)
		else
			render(json: {success: false, message: @list.errors.full_messages}, status: 200)
		end
	end

	def show
		@list = List.includes(:cards).find_by(id: params[:id] )
		if @list.present? 
			render "show.json"
		else
			render(json: {success: false, message: "List not found"}, status: 200)
		end
	end

	def update_list
		if @list.present? && @list.update(list_params)
			render(json: {success: true, message: 'List updated successfully'}, status: 200)
		else
			render(json: {success: false, message:  @list.present? ? @list.errors.full_messages : "List not found"}, status: 200)
		end
	end

	def destroy_list
		if @list.present? && @list.destroy
			render(json: {success: true, message: 'List deleted successfully'}, status: 200)
		else
			render(json: {success: false, message:  @list.present? ? @list.errors.full_messages : "List not found"}, status: 200)
		end
	end

	def assign_member
		if params[:user_id] == @current_user.id
			render(json: {success: false, message: "user id is not a valid id, you cannot assign list to yourself"}, status: 200)
		else
			@list_user = ListUser.new(list_id: params[:list_id], user_id: params[:user_id]) 
			if @list_user.save
				render(json: {success: true, message: 'User added successfully in the list'}, status: 200)
			else
				render(json: {success: false, message: @list_user.errors.full_messages}, status: 200)
			end
		end
	end

	def unassign_member
		@list_user = ListUser.find_by(list_id: params[:list_id], user_id: params[:user_id])
		if @list_user.present? && @list_user.destroy
			render(json: {success: true, message: 'User removed from list successfully'}, status: 200)
		else
			render(json: {success: false, message: @list_user.present? ? @list_user.errors.full_messages : "Invalid list_id or user_id"}, status: 200)
		end
	end

	private
	def list_params
		params[:list].permit(:title)
	end

	def set_list 
		@list = List.find_by(id: params[:list_id] )
	end
end
