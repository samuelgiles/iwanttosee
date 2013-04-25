class User < ActiveRecord::Base
  attr_accessible :name, :pictureurl, :provider, :uid
 	has_many :wishs

	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["info"]["name"]
			user.pictureurl = auth["info"]["image"]
		end
	end

end
