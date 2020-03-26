require_all 'lib'

class Movie < ActiveRecord::Base
    has_many :genre_movies
    has_many :genres, through: :genre_movies
    has_many :actor_movie
    has_many :actors, through: :actor_movie

    # validates :title,  :released, :runtime, :rating, :budget, :box_office, presence: true 

    def release_year
        self.released.year
    end

  
    def self.most_produced_genre #returns the genre in the most films
        genre_movies={}
        Genre.all.each do |genre|
            if !(genre_movies[genre.name])
                genre_movies[genre.name]=Genre.genre_movies(genre.name).count
            end
        end 
        x = genre_movies.first
        puts "#{x[1]} of the top 20 films were #{x[0]} movies!"
    end

    end

    def self.most_produced_genre #returns the genre in the most films
        genre_movies={}
        Genre.all.each do |genre|
            if !(genre_movies[genre.name])
                genre_movies[genre.name]=Genre.genre_movies(genre.name).count
            end
        end 
        x = genre_movies.first
        puts "#{x[0]} appears in #{x[1]} of the top 20 films!"
    end

    def self.get_movie_genres(movie_name)
        movie_id =  find_movie_id(movie_name)
        combo = GenresMovie.all.where(movie_id: movie_id)
        genre_arr = []
        combo.each do |gen_mov|
            genre_id = gen_mov.genre_id
            genre = Genre.all.where(id: genre_id)
            x = genre.map { |ele| ele.name }
            genre_arr << x #keeps returning "genre" instead of the actual name
        end
        genre_arr.flatten
    end
    
    def self.genres_by_year
        mby={} #returns hash with year keys and genre values
        Movie.all.each do |movie|
            if !(mby[movie.release_year])
                mby[movie.release_year] = []
            end 
            (Movie.get_movie_genres(movie.title)).each do |genre|
                mby[movie.release_year] << genre
            end
        end 
        mby
    end

    def self.most_genre_in_year(year) #given a year returns the genre produced the most
       x =  Movie.genres_by_year[year]
       genres={}
       x.each do |genre|
           if !(genres[genre])
               genres[genre] = 1
           else 
                genres[genre]+= 1
           end
       end 
       genres.first
    end



            genre_arr << genre.name #keeps returning "genre" instead of the actual name
        end
        genre_arr
    end
    
    def self.genres_by_year
        mby={} #returns hash with year keys and genre values. needs to be flattened
        Movie.all.each do |movie|
            if !(mby[movie.release_year])
                mby[movie.release_year] = Movie.get_movie_genres(movie.title)
            else 
                mby[movie.release_year].push(Movie.get_movie_genres(movie.title))
                mby[movie.release_year]
            end

        end 
        mby
    end

end

