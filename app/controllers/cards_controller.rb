class CardsController < ApplicationController
	before_action :set_card, only: [:show, :update, :destroy]
	# before_action :validate_token
	def index
		@cards = Card.all
		render(json: {results: @cards}, status: 200)
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

	def update
		if @card.update(card_params)
			render(json: {success: true, message: 'Card updated successfully'}, status: 200)
		else
			render(json: {success: false, message: @card.errors.full_messages}, status: 200)
		end
	end

	def destroy
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
end
