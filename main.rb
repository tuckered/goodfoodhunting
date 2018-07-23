# require 'sinatra/reloader' #only reloads this file by default, not the models files.     
require 'sinatra'
require 'pg'

# this function refactors the previous code that just connects to the sql database itself. 
def run_sql(sql)
  conn = PG.connect(dbname: 'goodfoodhunting')
  result = conn.exec(sql)
  conn.close
  return result
end

require_relative 'db_config'
require_relative 'models/dish'
require_relative 'models/comment'
require_relative 'models/user'
require_relative 'models/like'

# models relate to the tables

# sessions is a sinatra method
enable :sessions

# sinatra can make methods that you can share with views - called helpers

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    # if there's a current user return true, else false
    # !! converts to boolean. double negation. 
  
    if current_user # user object or nil
      return true
    else
      return false
    end

  end

end


get '/' do
  @dishes = Dish.all
  erb :index
end

# getting the form
get '/dishes/new' do
  erb :new
end

# shows dish details
get '/dishes/:id' do 
  @dish = Dish.find( params[:id])
  @comments = @dish.comments
  erb :dish_details
end

# create a dish
post '/dishes' do
  dish = Dish.new
  dish.name = params[:name]
  dish.image_url = params[:image_url]
  # record the user_id when creating a new dish because have to be logged in to create. 
  dish.user_id = current_user.id
  dish.save
  redirect '/' # needs to be a route - because its making a request
end

# delete a dish
delete '/dishes/:id' do
  dish = Dish.find( params[:id])
  dish.destroy
  redirect '/'
end

get '/dishes/:id/edit' do
  @dish = Dish.find(params[:id])
  erb :edit
end

put '/dishes/:id' do
  redirect '/login' unless logged_in?
  dish = Dish.find(params[:id])
  dish.name = params[:name]
  dish.image_url = params[:image_url]
  dish.save
  redirect "/dishes/#{ params[:id] }"
end


post '/comments' do
  # redirects a user from /comments if they're not logged in. 
  redirect '/login' unless logged_in?

  comment = Comment.new
  comment.content = params[:content]
  comment.dish_id = params[:dish_id]
  comment.user_id = current_user.id
  comment.save
  redirect "/dishes/#{ params[:dish_id] }"
end


get '/login' do
  erb :login
end

post '/session' do
  # STEPS FOR LOGIN 
  # grab email and password
  # find the user by mail
  user = User.find_by(email: params[:email])
  # authenticate user with password
  # we made the user object first the in the IF statement can check their email witht their password
  if user && user.authenticate(params[:password])
    # create new session
    # session is a sinatra
    # this is where :user_id is defined. 
    session[:user_id] = user.id
    # redirect to secret page
    redirect '/'
  else
    erb :login
  end
end


delete '/session' do
  # delete the session
  session[:user_id] = nil
  # take the user back to a GET session
  # redirect to /login
  redirect '/login'
end


post '/likes' do
  redirect '/login' unless logged_in?
  # insert a record into the likes table
  # creating a like
  like = Like.new
  like.dish_id = params[:dish_id]
  # here user is logged in so can search for current_user.id rather than going to the form to retrieve it. 
  like.user_id = current_user.id
  like.save
  redirect "/dishes/#{params[:dish_id]}"
end


# post '/session' do
  # STEPS FOR LOGIN 
  # grab email and password
  # find the user by mail
  # authenticate user with password
  # create new session
  # redirect to secret page
# end
