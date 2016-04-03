class Link < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :folders

	def isPoster? user
		user = self.user
	end
end