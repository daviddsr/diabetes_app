class GraphicsController < ApplicationController


	def index
		
	end

	def graphics_evolution

		@controls= Control.all
		@controls.to_json
		render json: @controls
	end
end
