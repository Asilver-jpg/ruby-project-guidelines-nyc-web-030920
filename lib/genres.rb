class Genre < ActiveRecord::Base
    has_many :genre_movies
    has_many :movies, through: :genre_movies

    validates :name, presence: true 

    def self.get_genres_actors(genre_name)
        actor_array = []
       genre_id=  Genre.all.find_by(name: genre_name).id
        movies = GenresMovie.all.where(genre_id: genre_id)
        movies.each do |movie|
            movie_id = movie.movie_id
            actors = ActorMovie.all.where(movie_id: movie_id)
            actors.map do |actor|
                actor_list = Actor.all.find_by(id: actor.actor_id).name
                actor_array << actor_list
            end
        end
     actor_array
    end

    #Genre per year. First need helper method to get all a genre's movies
    #then need to grab the year of each and count k:v = Year: number of movies

    def self.genre_movies(genre_name) #returns each movie instance associated with the genre given
        genre_id=  Genre.all.find_by(name: genre_name).id
        movies = GenresMovie.all.where(genre_id: genre_id)
        movies_arr = []
        movies.each do |movie|
            movie_id = movie.movie_id
            movie = Movie.find_by(id: movie_id)
           movies_arr << movie
        end 
        movies_arr
    end

    def self.get_all_genres_actors
        genre_actors={}
        Genre.all.each do |genre|
            if !(genre_actors[genre.name])
                genre_actors[genre.name]=Genre.get_genres_actors(genre.name)
            end
        end 
        genre_actors
    end


    def self.get_all_genres_movies
        genre_movies={}
        Genre.all.each do |genre|
            if !(genre_movies[genre.name])
                genre_movies[genre.name]=Genre.genre_movies(genre.name)
            end
        end 
        genre_movies
    end

    def self.genre_with_most_actors #returns the genre with the most actors
        genre_actors={}
        Genre.all.each do |genre|
            if !(genre_actors[genre.name])
                genre_actors[genre.name]=Genre.genre_movies(genre.name).count
            end
        end 
        x = genre_actors.first
        puts "#{x[0]} had the most actors"
    end

    def self.genre_with_least_actors #returns the genre with the least actors
        genre_actors={}
        Genre.all.each do |genre|
            if !(genre_actors[genre.name])
                genre_actors[genre.name]=Genre.genre_movies(genre.name).count
            end
        end 
       x = genre_actors.map do |k, v|
            k if v == 0 && v != nil
        end
        y = x.compact
        y.each do |final_genres|
            puts "\n#{final_genres} had the least actors
            \n"
        end
    end

    def self.genre_money(genre_name) #returns total made by all movies in genre given
        genre_id=  Genre.all.find_by(name: genre_name).id
        movies = GenresMovie.all.where(genre_id: genre_id)
        movies_arr = []
        movies.each do |movie|
            movie_id = movie.movie_id
            movie = Movie.find_by(id: movie_id).box_office
            movies_arr << movie
        end 
        each_money = movies_arr.compact

        total_money = each_money.sum

    end

    def self.genre_budget(genre_name) #returns total budget of all movies in genre given
        genre_id=  Genre.all.find_by(name: genre_name).id
        movies = GenresMovie.all.where(genre_id: genre_id)
        movies_arr = []
        movies.each do |movie|
            movie_id = movie.movie_id
            movie = Movie.find_by(id: movie_id).budget
            movies_arr << movie
        end
        each_budget = movies_arr.compact

        total_budget = each_budget.sum

    end

    def self.genre_with_most_money #returns the genre with the most money made
        genres_money={}
        Genre.all.each do |genre|
            if !(genres_money[genre.name])
                genres_money[genre.name]=Genre.genre_money(genre.name)
            end
        end 
        x = genres_money.first
        puts "\n#{x[0]} made the most money!
        \n"
    end

    def self.genre_with_least_money #returns the genre with the least money made
        genres_money={}
        Genre.all.each do |genre|
            if !(genres_money[genre.name])
                genres_money[genre.name]=Genre.genre_money(genre.name)
            end
        end 
       x = genres_money.map do |k, v|
            k if v == 0 && v != nil
        end
        y = x.compact
        puts "#{y[0]}, #{y[1]}, #{y[2]}, #{y[3]} and #{y[4]} all made the least money!"
    end

    def self.genre_with_most_budget #returns the genre with the highet budget
        genres_budget={}
        Genre.all.each do |genre|
            if !(genres_budget[genre.name])
                genres_budget[genre.name]=Genre.genre_budget(genre.name)
            end
        end 
        x = genres_budget.first
        puts "\n#{x[0]} had the highest budget!
        \n"
    end

    def self.genre_with_least_budget #returns the genre with the lowest budget
        genres_budget={}
        Genre.all.each do |genre|
            if !(genres_budget[genre.name])
                genres_budget[genre.name]=Genre.genre_budget(genre.name)
            end
        end 
       x = genres_budget.map do |k, v|
            k if v == 0 && v != nil
        end
        y = x.compact

        puts "#{y[0]}, #{y[1]}, #{y[2]}, #{y[3]}, #{y[4]} and #{y[5]} all had the lowest budget!"

    end


end