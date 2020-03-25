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
end 
