
# require_relative 'cli_class.rb'
require 'bundler'
Bundler.require
require 'require_all'
require 'tty-box'
require 'tty-prompt'
require 'tty-pie'
require_all 'lib'
require 'pry'
$VERBOSE = nil
# require_relative './config/environment.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil 

def banner 
    box = TTY::Box.frame(width:50, height:9, border: :thick, align: :left) do
       "          _______ __  __ _____  ____  
         |__   __|  \\/  |  _ _\\|  _ \\ 
            | |  | \\  / | |  | | |_) |
            | |  | |\\/| | |  | |  _ < 
            | |  | |  | | |__| | |_) |
            |_|  |_|  |_|_____/|____/ 
          Insignt on the top 20 movies!                                
                                                                                             
                                                                  
    " end

    print box 
end

@@prompt = TTY::Prompt.new(track_history: false)

def main_menu
    system("clear")
    banner
    @@prompt.select("Welcome, what would you like to learn about?") do |menu|
        menu.choice 'Movies', -> {movie_choice}
        menu.choice 'Genres', -> {genre_choice}
        menu.choice 'Actors', -> {actor_choice}
        menu.choice 'Exit', -> {exit}
    end
end

def run_application
    system("clear")
    banner

    main_menu
end 

def clean_slate
    system("clear")
    banner 
end

def movie_choice 
   clean_slate
    box = TTY::Box.frame(title: {top_left: 'Movies'}, align: :left) do 
    " What would you like to know about movies?"
    end 
    print box 
    movie_menu = @@prompt.select("options") do |movie|
        movie.choice 'Most popular genre', -> {most_produced_genre}
        movie.choice 'Distribution of movies by genre', -> {avg_genre_part}
        movie.choice 'Back', -> {main_menu}
        movie.choice 'Exit', -> {exit}
    end
end

def keep_exploring
    continue_resp = @@prompt.yes?('Do you want to keep exploring?')
    if continue_resp == true
        
        main_menu
    end
end

def exit
    exit_prompt = @@prompt.yes?('Are you sure you want to exit?')
    if exit_prompt == false
        main_menu
    end
end


def most_produced_genre
   Movie.most_produced_genre
   keep_exploring
end 


def genre_choice
    clean_slate
    box = TTY::Box.frame(title: {top_left: 'Genres'}, align: :left) do 
        " What would you like to know about genres?"
        end 
        print box
    genre_menu = @@prompt.select("options") do |genre|
        genre.choice 'Which genre produces the most money?', -> {genre_most_money}
        genre.choice 'Which genre has the bigest budget?', -> {genre_biggest_budget}
        genre.choice 'Which genre has the smallest budget?', -> {genre_smallest_budget}
        genre.choice 'Which genre has the least actors?', -> {genre_least_actors}
        genre.choice 'Most popular genre in a specific year', -> {genre_pop_by_year}
        genre.choice 'Which genre produces the least money?', -> {genre_least_money}
        genre.choice 'Which genre has the most actors?', -> {genre_most_actors}
        genre.choice 'Back', -> {main_menu}
        genre.choice 'Exit', -> {exit}
    end
end

def genre_pop_by_year
    puts "Which year do you want to know about?"
        input = get_input.to_i
        if Movie.year_exist?(input)
            puts "#{Movie.most_genre_in_year(input)}"
        else 
            puts "\nNone of the current top 20 movies were made in that year.
            \n"
        end 
        keep_exploring
end

def genre_least_money
    Genre.genre_with_least_money
    keep_exploring
end



def genre_most_money
    Genre.genre_with_most_money
    keep_exploring
end

def genre_most_actors
    Genre.genre_with_most_actors 
    keep_exploring
end

def genre_least_actors
    Genre.genre_with_least_actors 
    keep_exploring
end

def genre_smallest_budget
    Genre.genre_with_least_budget
    keep_exploring
end

def genre_biggest_budget
    Genre.genre_with_most_budget
    keep_exploring
end

def get_input
    input = gets.chomp
    input 
end

def actor_choice
    clean_slate
    box = TTY::Box.frame(title: {top_left: 'Actors'}, align: :left) do 
        " What would you like to know about actors?"
        end 
        print box
    actor_menu = @@prompt.select("options") do |actor|
        actor.choice 'Actor(s) who star in the most genres', -> {most_diverse_actor}
        actor.choice 'Percentage of genres for an actor based on their movies', -> {actor_genre_breakdown}
        actor.choice 'Back', -> {main_menu}
        actor.choice 'Exit', -> {exit}
    end
end

def avg_genre_part
    
    create_pie(Actor.average_genre_participation_hash, 20)
    keep_exploring
end

def actor_genre_breakdown
  
    puts "Which actor do you want to know about?"
        input = get_input 
        if Actor.actor_exist?(input)
       create_pie(Actor.get_actor_genres_percentage(input), 10)
        else 
            puts "\nThat actors is not currently in any of the top 20 movies.
            \n"
        end 
        keep_exploring
end

def most_diverse_actor
    puts "#{Actor.actor_largest_range}"
    keep_exploring
end


def create_pie(hash, radius)
    data= create_pie_data(hash)
    puts TTY::Pie.new(data:data, radius:radius)
end

def create_pie_data(hash)
    Color.create_data(hash)
end


run_application