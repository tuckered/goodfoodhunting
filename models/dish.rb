class Dish < ActiveRecord::Base
  # these add extra methods. 
  has_many :comments #plural because there's many
  belongs_to :user #singular because it specific. adding d1.user will give you the user_id. then can stack, d1.user.email
  has_many :likes # add likes method
end