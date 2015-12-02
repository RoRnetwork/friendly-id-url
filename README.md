# FriendlyId

<em>For the most complete, user-friendly documentation, see the [FriendlyId Guide](http://norman.github.io/friendly_id/file.Guide.html).</em>

FriendlyId is the "Swiss Army bulldozer" of slugging and permalink plugins for
Active Record. It lets you create pretty URLs and work with human-friendly
strings as if they were numeric ids.


If you want change the url `id` with `name` like [railscasts.com](http://railscasts.com/episodes/314-pretty-urls-with-friendlyid)

This is normal `ruby`method. here no need to use any gem. 

Simply add the following `method` into your `model` file.

````ruby

def to_param
  "#{id}-#{name}".parameterize
end

````
But If you want make Pretty URLs without showing the `id` in url, you can follow the below instructions 

```ruby
# Gemfile
gem 'friendly_id'
```
```console
rails generate friendly_id
```

If you want change the url of `User` model , add a field in `User` model as `slug:string:uniq`

````console
rails g migration AddSlugToUsers slug:string:uniq
rake db:migrate
````
```ruby
# edit app/models/user.rb
class User < ActiveRecord# edit app/models/user.rb::Base
  extend FriendlyId
  friendly_id :name, use: :slugged #here :name will be used instead of :id in url
end
```

```ruby
# Change User.find to User.friendly.find in your controller
User.friendly.find(params[:id])
```

Finders are no longer overridden by default. If you want to do friendly finds, you must do `Model.friendly`.find rather than `Model.find`. You can however restore FriendlyId 4-style finders by using the `:finders `addon:

````ruby
#change into your ../models/user.rb 

friendly_id :name, use: [:slugged, :finders] # you can now do MyClass.find('shan')

#now you can undo the changes from your Users_controller.rb

User.find(params[:id])

````

Normally while updating your `:name` field, `:slug` value won't change. 

To overcome this issue,

add this method into your `user.rb` model file

````ruby
def should_generate_new_friendly_id?
  slug.blank? || name_changed?
end

````

A new "candidates" functionality which makes it easy to set up a list of
  alternate slugs that can be used to uniquely distinguish records, rather than
  appending a sequence. For example:

  ```ruby
  class User < ActiveRecord::Base
    extend FriendlyId
    friendly_id :slug_candidates, use: [:slugged, :finders]

    # Try building a slug based on the following fields in
    # increasing order of specificity.
    def slug_candidates
	  [
	    :name,
	    [:name, :city],
	    [:name, :country, :city]    
	  ]
	end
  end
  ```
  Or  to make sequence number along with slug.
  
  ```ruby
  class User < ActiveRecord::Base
    extend FriendlyId
    friendly_id :slug_candidates, use: [:slugged, :finders]
    def slug_candidates
      [:name, :name_and_sequence]
    end

    def name_and_sequence
      slug = name.to_param
      sequence = User.where("slug like #{slug}--%").count + 2
      "#{slug}--#{sequence}"
    end
  end
  ```
  Now that candidates have been added, FriendlyId no longer uses a numeric
  sequence to differentiate conflicting slug, but rather a UUID (e.g. something
  like `2bc08962-b3dd-4f29-b2e6-244710c86106`). This makes the
  codebase simpler and more reliable when running concurrently, at the expense
  of uglier ids being generated when there are conflicts.


  If you want to override the default `-` url with some other format. For example, In the case of changing the `-` as `_` in the url.

  ````ruby
  #add the following method in model file
   def normalize_friendly_id(string)
    super.gsub("-", "_")
   end

 ````
## Thanks and Credits

https://github.com/norman/friendly_id
