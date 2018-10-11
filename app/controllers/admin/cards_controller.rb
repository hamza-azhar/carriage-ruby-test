class Admin::CardsController < Admin::BaseController
	before_action :set_card, only: [:update_card, :destroy_card]
	before_action :validate_index_params, only: :index
	
	def index
		@list = List.includes(:cards).find_by(id: params[:list_id])
		if @list.present? 
			@cards = @list.cards
			render(json: {results: @cards}, status: 200)
		else
			render(json: {success: false, message: "Invalid list"}, status: 200)
		end
	end

	def create
		@list = List.includes(:cards).find_by(id: params[:list_id])
		if @list.present?
			@card = @list.cards.build(card_params)
			if @card.save!
				render(json: {success: true, message: 'Card added successfully'}, status: 200)
			else
				render(json: {success: false, message: @card.errors.full_messages}, status: 200)
			end
		else
			render(json: {success: false, message: "Invalid list"}, status: 200)
		end
	end

	def show
		@card = Card.includes(:comments).find_by(id: params[:id])
		if @card.present?
			render "show.json"
		else
			render(json: {success: false, message: "Card not found"}, status: 200)
		end
	end

	def update_card
		if @card.present? && @card.update(card_params)
			render(json: {success: true, message: 'Card updated successfully'}, status: 200)
		else
			render(json: {success: false, message: @card.present? ? @card.errors.full_messages : "Card not found"}, status: 200)
		end
	end

	def destroy_card
		if @card.present? && @card.destroy
			render(json: {success: true, message: 'Card deleted successfully'}, status: 200)
		else
			render(json: {success: false, message: @card.present? ? @card.errors.full_messages : "Card not found"}, status: 200)
		end
	end

	private
	def card_params
		params[:card].permit(:title, :description, :list_id)
	end

	def set_card 
		@card = Card.find_by(id: params[:card_id])
	end

	def validate_index_params
		@error_message = []
		@error_message << "list_id must be present." if !params[:list_id].present?
		if @error_message.present?
			render(json: {ok: false, error: @error_message, status: 401}, status: 401) and return
		end
	end
end
