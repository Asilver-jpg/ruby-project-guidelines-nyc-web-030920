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
    menu.choice "run thing", -> {Actor.average_genre_participation_hash}
end
end

run_application

puts "HELLO WORLD"
