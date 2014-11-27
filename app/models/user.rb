class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :controls
	has_many :months

	has_many :meals

	validates :name, presence: true
	validates :ratioinsuline, presence: true
end
