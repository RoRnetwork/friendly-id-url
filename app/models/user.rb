class User < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :slug_candidates, use:  [:slugged, :finders]
  	def slug_candidates
	  [
	    :name,
	    [:name, :city],
	    [:name, :country, :city]    
	  ]
	end
  	def should_generate_new_friendly_id?
	  slug.blank? || name_changed?
	end
	#def normalize_friendly_id(string)
    	#super.gsub("-", "_")
   	#end
   	#def to_param
    #  "#{id}-#{name}".parameterize
  	#end
end
