class Control < ActiveRecord::Base

	validates :level, presence: true
	validates :period, presence: true
	validates :day, presence: true
	validates :level, :numericality => { :greater_than => 24, :less_than_or_equal_to => 600 }
	# validates_datetime :day, :after {Control.day + 30.minutes}

	belongs_to :user

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


	

	def self.graphic_data_for_a_day(user_id, day)
		controls= Control.compare_day(day, user_id)
		controls_array=	controls.map do |control|
				[control.day.strftime("%I:%M%p").to_time.utc.to_i * 1000, control.level]

		end
		controls_array = controls_array.sort do |a,b| a[0] <=> b[0] end
		graphic_data = {  name: "day",
						  data: controls_array
										}
    	graphic_data
	end

	def self.graphic_data_for_all_days(user_id)
		graphic_data = []
		Control.list_days_controls(user_id).each do |day|
			graphic_data.push(Control.graphic_data_for_a_day(user_id, day.to_s,))
		end
		graphic_data
	end

	def self.levels_average(user_id)
		levels_average = 0
		if Control.count > 0
			levels = Control.where(user_id: user_id).map { |control| control.level } 
			levels_average = levels.reduce(:+).to_f / levels.size 
		 end
		levels_average
	end

	def self.controls_by_day_average(user_id)
		return 0.0 if Control.count == 0
		sign_up_date = User.find(user_id).created_at
		
		difference_days = (DateTime.now.to_date - sign_up_date.to_date).to_i
		difference_days = 1 if difference_days == 0

		controls = Control.where(user_id: user_id)
		controls_average = (controls.size / difference_days.to_f)
		controls_average
	end	
	
	def self.last_control_level(user_id)
		controls = Control.where(user_id: user_id).sort_by { |control| control.day }
		last_control = controls.last.level if controls.last
		last_control
	end
	
	private
	
	def self.compare_day(day, user_id) 
		where(user_id: user_id).select do |control|
			 control.day.to_date == day.to_date
		end
	end

	def self.list_days_controls(user_id)
		days=[]
		where(user_id: user_id).each do |control|
			unless days.include?(control.day.to_date)
				days.push(control.day.to_date)
			end
			end
		days
	end
    
end


