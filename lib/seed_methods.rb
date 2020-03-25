
require "net/http"
require 'pry'
require_relative 'genres.rb'

def valid_movie(movie)
    if movie["adult"] !=nil && movie["budget"]!=nil && movie["genres"] != nil && movie["revenue"]!=nil && movie["runtime"]!=nil
    if movie["adult"] ==false && movie["budget"]!=0 && movie["genres"].length != 0 && movie["revenue"]!=0 && movie["runtime"]!=0 
        return true
    else
        return false
    end
end 
end 

def find_genre_id(id)
    Genre.all.find_by(genre_id: id).id
end
def find_actor_id(name)
    Actor.all.find_by(name: name).id
end
def find_movie_id(title)
    Movie.all.find_by(title: title).id
end