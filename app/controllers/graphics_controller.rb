class GraphicsController < ApplicationController
	def index

	end

	def graphics_evolution
		@controls = Control.all
		render json: @controls.to_json
	end
end
