require "pry"
require "tty-pie"
class Actor < ActiveRecord::Base
    has_many :actor_movie
    has_many :movies, through: :actor_movie
    validates :name, presence: true 
    #get names of all actors
    def self.names
       Actor.all.map do |actor|
         actor.name
        end
    end

    def self.actor_exist?(actor_name)
        names = Actor.names
        names.include?(actor_name)
    end

    #get actor name by their id
    def self.get_actor_name_by_id(id)
        name= Actor.find_by(id: id).name
    end

   #get ActorMovie based on actor's name
   def self.get_actor_movie(actor_name)
    actor_id= Actor.find_by(name: actor_name).id
    movies= ActorMovie.where(actor_id: actor_id)
    end
   
    #return a list of all actor's genres per movie BY NAME
    def self.get_actor_genres(actor_name)
        movies= Actor.get_actor_movie(actor_name)
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

    
        #gets all of the actors' genres
    def self.get_all_actor_genres
        actor_genres={}
        Actor.all.each do |actor|
            if !(actor_genres[actor.name])
                actor_genres[actor.name]=Actor.get_actor_genres(actor.name)
            end
        end 
        actor_genres
    end

    #figures out which actor has the largest range of genres
    def self.actor_largest_range
        actor_genres= Actor.get_all_actor_genres.uniq
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
        Actor.print_actor_largest_range(actor_string, curr_highest)
    end

    #print statement for actor_largest range
def self.print_actor_largest_range(actor_string, curr_highest)
     if Actor.actor_plural(actor_string)
        return "\nThe actors that star in the most genres of film are #{actor_string_parse(actor_string)}, and they star in #{curr_highest} genres.
        \n"
    else
        return "\nThe actor that stars in the most genres of film is #{actor_string}. They star in #{curr_highest} genres.
        \n"
    end
end
 #checks if more than one string element
def self.actor_plural(str)
    actors= str.split
    if actors.count>1
        return true
    else    
        return false
    end 
end



 #finds the percent average of all values in a genre hash
 def self.average_genre_participation_hash
    genre_totals= Actor.genre_totals
    total= Actor.total(genre_totals)
    genre_percent=genre_totals.each do |key, val|
        genre_totals[key] = ((val.to_f/total.to_f)*100).round
    end
    genre_percent
end

  #gets total of all genres 
  def self.genre_totals
    actor_genres = Actor.get_all_actor_genres
    genre_percent= Hash.new(0)
    actor_genres.each do |name, genres| 
        genres.each do |genre|
            genre_percent[genre] +=1
    end
end
    genre_percent
  end
   
  # totals up values of hash
  def self.total(hash)
    total=0
    hash.each do |key,val|
        total+=val
    end
    total
  end

  #print statment for average_genre_participation_hash
  def self.print_average_genre_participation_actors(genre_percentage)
    output =""
    genre_percentage.each do |key, value|
        output+= "#{key} : #{value}%" + "\n"
    end
        return "\nThe percent of each genre for the top 20 movies is: \n #{output}
        \n"
  end

  #% of genre for an actor
  def self.actor_genre_participation(actor_name)
    genres= Actor.get_actor_genres(actor_name)

  end
  
  def self.get_actor_genres_percentage(actor_name)
        actor_genres= Actor.get_actor_genres(actor_name)
        actor_genre_count= Actor.count_an_actors_genres(actor_genres)
        total= Actor.total(actor_genre_count)
        genre_percent=actor_genre_count.each do |key, val|
            actor_genre_count[key] = ((val.to_f/total.to_f)*100).round
        end
        genre_percent
    end
    def self.print_actor_percent(genre_percentage, actor_name)
        output =""
        genre_percentage.each do |key, value|
            output+= "#{key} : #{value}%" + "\n"
        end
            return "\nThe percent of movies per genre that #{actor_name} is in is: \n #{output}
            \n"
    end
    def self.count_an_actors_genres(genre_array)
        count = Hash.new(0)
        genre_array.each {|genre| count[genre] +=1}
        count
        end
def self.test_pie()
    data = [
        { name: 'BTC', value: 50, color: :bright_yellow, fill: '*' },
        { name: 'BCH', value: 50, color: :bright_green, fill: 'x' },
        { name: 'LTC', value: 50, color: :bright_magenta, fill: '@' },
        { name: 'ETH', value: 50, color: :bright_cyan, fill: '+' }
      ]
      pie_chart = TTY::Pie.new(data: data, radius: 5)
      puts pie_chart
end
end
#end of class



def actor_string_parse(str)
    actors = str.split(", ")
    actors[-1] = ", and #{actors[-1]}"
    actors.join(" ")
end
