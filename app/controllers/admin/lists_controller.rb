class Admin::ListsController < Admin::BaseController
	before_action :set_list, only: [:show, :update, :destroy]

	def index
		@lists = List.all
		render(json: { success: true, results: @lists }, status: 200)
	end

	def create
		@list = List.new(list_params)
		if @list.save!
			render(json: {success: true, message: 'List added successfully'}, status: 200)
		else
			render(json: {success: false, message: @list.errors.full_messages}, status: 200)
		end
	end

	def show
		render "show.json"
	end

	def update
		if @list.present? && @list.update(list_params)
			render(json: {success: true, message: 'List updated successfully'}, status: 200)
		else
			render(json: {success: false, message: @list.errors.full_messages}, status: 200)
		end
	end

	def destroy
		if @list.present? && @list.destroy
			render(json: {success: true, message: 'List deleted successfully'}, status: 200)
		else
			render(json: {success: false, message: @list.errors.full_messages}, status: 200)
		end
	end

	def assign_member
		@list_user = ListUser.new(list_id: params[:list_id], user_id: params[:user_id])
		if @list_user.save!
			render(json: {success: true, message: 'User added successfully in the list'}, status: 200)
		else
			render(json: {success: false, message: @list_user.errors.full_messages}, status: 200)
		end
	end

	def unassign_member
		@list_user = ListUser.find_by(list_id: params[:list_id], user_id: params[:user_id])
		if @list_user.present? && @list_user.destroy
			render(json: {success: true, message: 'User removed from list successfully'}, status: 200)
		else
			render(json: {success: false, message: @list.errors.full_messages}, status: 200)
		end
	end

	private
	def list_params
		params[:list].permit(:title)
	end

	def set_list 
		@list = List.find_by(id: params[:id] )
	end
end
