class Control < ActiveRecord::Base

	validates :level, presence: true
	validates :period, presence: true
	validates :day, presence: true

	scope :by_day, ->(day) { where("day like ?", "#{day}%") }

	@@periods= [
		'pre-breakfast',
		'post-breakfast',
		'pre-lunch',
		'post-lunch',
		'afternoon',
		'pre-dinner',
		'post-dinner'
	]

	def self.periods
		@@periods
	end

	def get_day
		calendar_day = DateTime.new(day.year, day.month, day.day)
		calendar_day
	end

	def self.order_by_date (user_id)
		controls = Control.where(user_id: user_id)
		controls = controls.sort_by { |control| [control.day]}
		controls = controls.sort do |a,b| a[0] <=> b[0] end
			controls = controls.reverse
	end


	def self.compareDay(day, user_id)
		where(user_id: user_id).select do |control|
			 control.day.to_date == day.to_date
		end
	end

	def self.graphic_data_for_a_day(day, user_id)
		
	#	controls = by_day day
		controls= Control.compareDay(day, user_id)
		controls_array=	controls.map do |control|
				[control.day.strftime("%I:%M%p").to_time.utc.to_i * 1000, control.level]

			end

			controls_array = controls_array.sort do |a,b| a[0] <=> b[0] end
		graphic_data = {  name: "day",
											data: controls_array

											
									   }
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

	def self.controls_average (user_id)

		controls = Control.where(user_id: user_id)
		sum= 0
		Control.all.where(user_id: user_id).each do |control|
			
		sum = sum + control.level
		end
		media = sum/controls.length
		media
	end

	def self.controls_day_average (user_id)

		controls= Control.where(user_id: user_id)
		dates= controls.all.map { |control| control.day.strftime("%d-%m-%Y") }
		days = []
		dates.each do |date|
    	unless days.include?(date)
    		days.push(date)
    		days
    	end
    end

    number_control_average = controls.length / days.length
    number_control_average
	end


	def self.lastcontrol (user_id)

	controls = Control.where(user_id: user_id).sort_by { |control| [control.day]}
	lastcontrol = controls.last.level
	lastcontrol

	end
	

	

end