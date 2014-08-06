# FriendlyId

<em>For the most complete, user-friendly documentation, see the [FriendlyId Guide](http://norman.github.io/friendly_id/file.Guide.html).</em>

FriendlyId is the "Swiss Army bulldozer" of slugging and permalink plugins for
Active Record. It lets you create pretty URLs and work with human-friendly
strings as if they were numeric ids.

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