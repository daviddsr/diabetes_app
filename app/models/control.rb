class Control < ActiveRecord::Base
	belongs_to :user
	belongs_to :month
end
