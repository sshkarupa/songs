require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require './song.rb'

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

get '/login' do
  slim :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end

get('/styles.css'){ sass :styles, style: :compressed }

get '/' do
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  @title = "Get in touch"
  slim :contact
end

not_found do
  slim :not_found
end