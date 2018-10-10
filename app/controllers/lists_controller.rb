class ListsController < ApplicationController
	before_action :set_list, only: [:show, :update, :destroy]

	def index
		@lists = List.all
		render(json: {results: @lists}, status: 200)
	end

	def show
		render "show.json"
	end

	private
	def list_params
		params[:list].permit(:title)
	end

	def set_list 
		@list = List.find(params[:id])
	end
end
