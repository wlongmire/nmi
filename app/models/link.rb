class Link < ActiveRecord::Base
	validates :name, presence:true
	validates :url, presence:true

	belongs_to :user
	belongs_to :region

	has_and_belongs_to_many :folders
	has_and_belongs_to_many :followers, join_table: "followees_followers", class_name: "User", foreign_key: "followee_id", association_foreign_key: "follower_id"

	def isPoster? user
		user = self.user
	end
end