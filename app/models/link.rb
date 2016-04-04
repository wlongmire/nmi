class Link < ActiveRecord::Base
	validates :name, presence:true
	validates :url, presence:true

	belongs_to :user
	belongs_to :region
	has_and_belongs_to_many :folders

	def isPoster? user
		user = self.user
	end
end