# require_relative 'cli_class.rb'
require 'bundler'
Bundler.require
require 'require_all'
require 'tty-box'
require 'tty-prompt'
# require_all 'lib'
# require_relative './config/environment.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

def banner 
    box = TTY::Box.frame(width:65, height:10, border: :thick, align: :left) do
       " 
         _______        _   
        |__   __|      | |  
           | | ___  ___| |_ 
           | |/ _ \\/ __| __|
           | |  __/\\__ \\ |_ 
           |_|\\___||___/\\__|
                           
    " end

    print box 
end

def run_application
    prompt = TTY::Prompt.new 
    system("clear")
    banner

main_menu = prompt.select("Welcome, what would you like to learn about?") do |menu|
    menu.choice 'Movies'
    menu.choice 'Genres'
    menu.choice 'Actors'
end

if main_menu == 'Movies'
    system("clear")
    puts "what would you like to know about movies"
    movie_menu = prompt.select("options") do |movie|
        movie.choice 'most popular genres'
        movie.choice 'most actors in a movie'
        movie.choice 'back'
    end
end

if movie_menu == 'back'
    system("clear")
    main_menu
end 

if movie_menu == 'most popular genres'
    system("clear")
    binding.pry
    Movie.most_produced_genre
end 

if main_menu == 'Movies'
    system("clear")
    puts "what would you like to know about movies"
    movie_menu = prompt.select("options") do |movie|
        movie.choice 'most populat genres'
        movie.choice 'most actors in a movie'
    end
end


if main_menu == 'Genres'
    system("clear")
    puts "what would you like to know about genres"
    genre_menu = prompt.select("options") do |genre|
        genre.choice 'most populat genres'
        genre.choice 'all movies in a certain genre'
    end
end

if main_menu == 'Actors'
    system("clear")
    puts "what would you like to know about actors"
    actor_menu = prompt.select("options") do |actor|
        actor.choice 'actor with most diverse genre set'
        actor.choice 'actors genre breakdown'
    end
end

end 

run_application