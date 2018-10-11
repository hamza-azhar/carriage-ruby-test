class CardsController < ApplicationController
	before_action :validate_token, :validate_member
	before_action :set_card, only: [:show, :update_card, :destroy_card]
	before_action :list_belongs_to_user?, only: [:create, :show, :update_card, :destroy_card]
	def index
		@lists = @current_user.lists.includes(:cards)
		render "index.json"
	end

	def create
		@card = Card.new(card_params)
		if @card.save!
			render(json: {success: true, message: 'Card added successfully'}, status: 200)
		else
			render(json: {success: false, message: @card.errors.full_messages}, status: 200)
		end
	end

	def show
		render "show.json"
	end

	def update_card
		if @card.update(card_params)
			render(json: {success: true, message: 'Card updated successfully'}, status: 200)
		else
			render(json: {success: false, message: @card.errors.full_messages}, status: 200)
		end
	end

	def destroy_card
		if @card.destroy
			render(json: {success: true, message: 'Card deleted successfully'}, status: 200)
		else
			render(json: {success: false, message: @card.errors.full_messages}, status: 200)
		end
	end

	private
	def card_params
		params[:card].permit(:title, :description, :list_id)
	end

	def set_card 
		@card = Card.find(params[:id])
	end

	def list_belongs_to_user?
		@error_message = []
		@error_message << "Permission Denied, you cannot access this list" unless @current_user.lists.map(&:id).include?(@card.list_id)
		if @error_message.present?
			render(json: {ok: false, error: @error_message, status: 401}, status: 401) and return
		end
	end
end
