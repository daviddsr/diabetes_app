class Control < ActiveRecord::Base

	validates :level, presence: true
	validates :period, presence: true
	validates :day, presence: true

	@@periods= [
		'1.- pre-breakfast',
		'2.- post-breakfast',
		'3.- pre-lunch',
		'4.- post-lunch',
		'5.- afternoon',
		'6.- pre-dinner',
		'7.- post-dinner'
	]

	def self.periods
		@@periods
	end

	def get_day
		calendar_day = DateTime.new(day.year, day.month, day.day)
		calendar_day
	end

	def self.order_by_date
		@controls = Control.all.sort_by { |control| [control.get_day, control.period]}
	end
end
