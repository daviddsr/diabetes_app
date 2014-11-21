class Control < ActiveRecord::Base

	validates :level, presence: true
	validates :period, presence: true
	validates :day, presence: true

	scope :by_day, ->(day) { where("day like ?", "#{day}%") }

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

	def self.graphic_data_for_a_day day
		controls = by_day day
    dates = dates_in_controls controls
    hours = hours_from_dates dates
    levels = levels_from_controls controls
		graphic_data = { labels: hours, data: levels }
    graphic_data
	end

	def self.dates_in_controls controls
		dates = []
		controls.each { |control| dates << control.day }
		dates
	end

	def self.hours_from_dates dates
		hours = []
		dates.each { |date| hours << date.strftime("%I:%M%p")}
		hours
	end

	def self.levels_from_controls controls
		levels = []
		controls.each { |control| levels << control.level }
		levels
	end
end
