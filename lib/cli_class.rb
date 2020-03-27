require 'tty-box'
require 'tty-prompt'
require 'bundler'
# require '../config/environment.rb'
require 'require_all'
Bundler.require


class Cli < ActiveRecord::Base

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

def self.run_application
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
    end
end

if movie_menu == 'most popular genres'
    system("clear")
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


end 

end 
