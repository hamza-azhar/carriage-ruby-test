class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :update, :destroy]

	def index
		@comments = params[:card_id].present? ? Comment.card_comments(params[:card_id]).paginate(page: params[:page], per_page: 5) : Comment.comment_replies(params[:comment_id].paginate(page: params[:page], per_page: 5))
		render(json: {results: @comments}, status: 200)
	end

	def create
		@comment = Comment.new(comments_params)
		@comment.card_id = params[:card_id] if params[:card_id].present?
		@comment.replier_id = params[:replier_id] if params[:replier_id].present?

		if @comment.save!
			render(json: {success: true, message: 'Comment added successfully'}, status: 200)
		else
			render(json: {success: false, message: @comment.errors.full_messages}, status: 200)
		end
	end

	def show
		render(json: {results: @comment.replies}, status: 200)
	end

	def update
		if @comment.update(comment_params)
			render(json: {success: true, message: 'Comment updated successfully'}, status: 200)
		else
			render(json: {success: false, message: @comment.errors.full_messages}, status: 200)
		end
	end

	def destroy
		if @comment.destroy
			render(json: {success: true, message: 'Comment deleted successfully'}, status: 200)
		else
			render(json: {success: false, message: @comment.errors.full_messages}, status: 200)
		end
	end

	private
	def comment_params
		params[:card].permit(:content)
	end

	def set_comment
		@comment = Comment.find(params[:id])
	end
end
