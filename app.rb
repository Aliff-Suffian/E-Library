require 'sinatra'
require 'sinatra/activerecord'

require 'bcrypt'

require_relative 'models/book'
require_relative 'models/review'
require_relative 'models/user'

get '/' do 
    erb :homepage
end

post '/new-book' do 
    @book = Book.create(title: params[:title], description: params[:description], author: params[:author], published_year: params[:published_year])
    if @book.save
        erb :book
    else
    redirect '/'
    end
end

get '/book/:id' do 
    @book = Book.find(params[:id])
    erb :book
end

get '/library' do 
    @library = Book.all
    erb :library
end

post '/library' do 
    @library = Book.all
    erb :library
end

get '/library/edit/:id' do 
    @book = Book.find(params[:id])
    erb :edit
end 

post '/edit/:id' do 
    @book = Book.find(params[:id])
    @book.update(title: params[:title], description: params[:description], author: params[:author], published_year: params[:published_year])
    erb :book
end

post '/library/delete/:id' do 
    @book = Book.find(params[:id])
    if @book
        @book.destroy
        redirect '/library'
    else
        redirect '/'
    end
end

get '/review' do
    @review = Review.all
    erb :review
end

post '/add-review' do
    @review = Review.create(name: params[:name], title: params[:title], feedback: params[:feedback], score: params[:score])
    if @review.save
        erb :book
    else
        redirect '/'
    end
end

get '/register' do 
    erb :register
end

post '/register' do 
    @user = User.create(username: params[:username], password: [:password])
    if @user.save
        redirect '/login'
    else
        redirect '/register'
    end
end

get '/login' do 
    erb :login
end
