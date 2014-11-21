class GraphicsController < ApplicationController
	def index

	end

	def graphics_evolution
    graphic_data = Control.graphic_data_for_a_day "2014-11-21"
		render json: graphic_data.to_json
	end
end
