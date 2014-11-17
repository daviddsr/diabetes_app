class Control < ActiveRecord::Base
	
	validates :level, presence: true 
	validates :period, presence: true
	validates :day, presence: true

	@@periods= ['pre-breakfast', 'post-breakfast', 'pre-lunch', 'post-lunch', 'afternoon', 'pre-dinner', 'post-dinner']

	def self.periods
		@@periods
	end


end
