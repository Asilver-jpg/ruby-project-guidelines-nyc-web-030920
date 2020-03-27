
# require_relative 'cli_class.rb'
require 'bundler'
Bundler.require
require 'require_all'
require 'tty-box'
require 'tty-prompt'
require_all 'lib'
$VERBOSE = nil
# require_relative './config/environment.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil 

def banner 
    box = TTY::Box.frame(width:65, height:10, border: :thick, align: :left) do
       " 
        _______ __  __ _____  ____  
       |__   __|  \\/  |  __\\ |  _ \\ 
          | |  | \\  / | |  | | |_) |
          | |  | |\\/| | |  | |  _ < 
          | |  | |  | | |__| | |_) |
          |_|  |_|  |_|_____/|____/ 
                                    
                                                                                             
                                                                  
    " end

    print box 
end

@@prompt = TTY::Prompt.new

def main_menu
    @@prompt.select("Welcome, what would you like to learn about?") do |menu|
        menu.choice 'Movies', -> {movie_choice}
        menu.choice 'Genres', -> {genre_choice}
        menu.choice 'Actors', -> {actor_choice}
        menu.choice 'exit', -> {exit}
    end
end

def run_application
    system("clear")
    banner

    main_menu
end 

def movie_choice
    puts "what would you like to know about movies"
    movie_menu = @@prompt.select("options") do |movie|
        movie.choice 'most popular genre', -> {most_produced_genre}
        movie.choice 'genre percentages breakdown', -> {avg_genre_part}
        movie.choice 'back', -> {main_menu}
        movie.choice 'exit', -> {exit}
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
    puts "what would you like to know about genres"
    genre_menu = @@prompt.select("options") do |genre|
        genre.choice 'Which genre produces the most money?', -> {genre_most_money}
        genre.choice 'Which genre has the bigest budget?', -> {genre_biggest_budget}
        genre.choice 'Which genre has the least actors?', -> {genre_least_actors}
        genre.choice 'Most popular genre in a specific year', -> {genre_pop_by_year}
        genre.choice 'back', -> {main_menu}
        genre.choice 'exit', -> {exit}
    end
end

def genre_pop_by_year
    puts "Which year do you want to know about?"
        input = get_input.to_i
        if Movie.year_exist?(input)
            puts "#{Movie.most_genre_in_year(input)}"
        else 
            puts "None of the current top 20 movies were made in that year."
        end 
        keep_exploring
end

def genre_most_money
    Genre.genre_with_most_money
    keep_exploring
end

def genre_least_actors
    Genre.genre_with_least_actors 
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
    puts "what would you like to know about actors"
    actor_menu = @@prompt.select("options") do |actor|
        actor.choice 'actor with most diverse genre set', -> {most_diverse_actor}
        actor.choice 'actors genre breakdown', -> {actor_genre_breakdown}
        actor.choice 'back', -> {main_menu}
        actor.choice 'exit', -> {exit}
    end
end

def avg_genre_part
    puts "#{Actor.average_genre_participation_hash}"
    keep_exploring
end

def actor_genre_breakdown
    puts "Which actor do you want to know about?"
        input = get_input
        if Actor.actor_exist?(input)
       puts "#{Actor.get_actor_genres_percentage(input)}" 
        else 
            puts "That actors is not currently in any of the top 20 movies."
        end 
        keep_exploring
end

def most_diverse_actor
    puts "#{Actor.actor_largest_range}"
    keep_exploring
end


run_application