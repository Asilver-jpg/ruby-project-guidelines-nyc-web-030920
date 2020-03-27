require_relative '../config/environment'

require 'tty-prompt'

@@prompt= TTY::Prompt.new
def run_application 

system("clear")
menu
end

def menu
    system "clear"

@@prompt.select("What u wanna do?") do |menu|
    menu.choice "run thing", -> { puts Actor.average_genre_participation_hash}
    menu.choice "run thing 2"
end
end

def use_method
   
end

run_application

puts "HELLO WORLD"
