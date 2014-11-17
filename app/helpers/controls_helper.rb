module ControlsHelper

	def notice
		if flash[:notice]
			flash[:notice]
		end
	end

	

end
