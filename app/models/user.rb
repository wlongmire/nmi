class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates :username, presence:true

  	has_many :links
    has_and_belongs_to_many :followees, join_table: "followees_followers", class_name: "Link", foreign_key: "follower_id", association_foreign_key: "followee_id"

  	def isAdmin?
  		return self.admin
  	end

end