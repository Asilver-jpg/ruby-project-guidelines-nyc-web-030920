require 'tty-prompt'
require "require_all"
require_all "./lib"
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