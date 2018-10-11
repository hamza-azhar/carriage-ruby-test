class CommentsController < Admin::BaseController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :validate_comment, only: [:show, :update, :destroy]
  before_action :validate_list, only: [:update, :destroy]

  def index
    @comments = Comment.all
    @comments = @comments.paginate(page: params[:page], per_page: 5) if @comments.present?
    render(json: {results: @comments}, status: 200)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.card_id = params[:card_id] if params[:card_id].present?
    @comment.comment_id = params[:comment_id] if params[:comment_id].present?
    if @comment.save
      render(json: {success: true, message: 'Comment added successfully'}, status: 200)
    else
      render(json: {success: false, message: @comment.errors.full_messages}, status: 401)
    end
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
    params[:comment].permit(:content)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def validate_comment
    unless @comment.present?
      render(json: {success: false, message: "No Comment Found"}, status: 404)
    end
  end

  def validate_list
    unless (comment.card.list.list_users.where(is_creator: true).first == @current_user)
      render(json: {success: false, message: "Access Denied"}, status: 403)
    end
  end
end
