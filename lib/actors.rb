require "pry"
class Actor < ActiveRecord::Base
    has_many :actor_movie
    has_many :movies, through: :actor_movie
    validates :name, presence: true 
    def self.names
       Actor.all.map do |actor|
         actor.name
        end
    end
    def self.get_actor_name_by_id(id)
        name= Actor.find_by(id: id).name
    end
   
    def self.get_actor_genres(actor_name)
       actor_id= Actor.find_by(name: actor_name).id
        movies= ActorMovie.where(actor_id: actor_id)
        genre_array=[]
        movies.each do |movie|
            movie_id = movie.movie_id
            genres= GenresMovie.all.where(movie_id:movie_id)
            genres.map do |genre|
                genre_list= Genre.all.find_by(id: genre.genre_id).name
                genre_array << genre_list     
            end
        end
        genre_array.flatten
    end


    

    def self.get_all_actor_genres
        actor_genres={}
        Actor.all.each do |actor|
            if !(actor_genres[actor.name])
                actor_genres[actor.name]=Actor.get_actor_genres(actor.name)
            end
        end 
        actor_genres
    end

    def self.actor_largest_range
        actor_genres= Actor.get_all_actor_genres
        actor_string=""
        curr_highest=0
        genre_count=0
        actor_genres.each do |name, genres|
            genre_count= genres.count
            if genre_count >curr_highest
                actor_string =name
                curr_highest=genre_count
            elsif genre_count == curr_highest
                actor_string += ", #{name}"
            end
        end
        if actor_plural(actor_string)
            return "The actors that star in the most genres of film are #{actor_string_parse(actor_string)}, they star in #{curr_highest} genres."
        else
            return "The actor that stars in the most genres of film is #{actor_string}, they star in #{curr_highest} genres."
        end
    end
  
end 

def actor_plural(str)
    actors= str.split
    if actors.count>1
        return true
    else    
        return false
    end 
end

def actor_string_parse(str)
    actors = str.split(", ")
    actors[-1] = ", and #{actors[-1]}"
    actors.join(" ")
end
