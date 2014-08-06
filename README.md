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

