class Control < ActiveRecord::Base
	
	validates :level, presence: true 
	validates :period, presence: true
	validates :day, presence: true

	@@periods= ['1.- pre-breakfast', '2.- post-breakfast', '3.- pre-lunch', '4.- post-lunch', '5.- afternoon', '6.- pre-dinner', '7.- post-dinner']


	def self.periods
		@@periods
	end

	def self.order_by_date
		@controls= Control.all.sort_by { |control| [control.day, control.period]}
	end


end
