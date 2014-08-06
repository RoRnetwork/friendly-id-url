class User < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]
  	
  	def should_generate_new_friendly_id?
	  slug.blank? || name_changed?
	end
end
