class User < ActiveRecord::Base
  has_secure_password
  # adds a method - password
  # add another method - authenticate
  # user.authenticate('password')
end