require 'pry'
require 'rest-client'
require 'json'

Movie.destroy_all
Actor.destroy_all
Genre.destroy_all
GenresMovie.destroy_all
ActorMovie.destroy_all

latest = RestClient.get("https://api.themoviedb.org/3/movie/latest?api_key=f7aed4cdd4714e239a74cd8b6e37e07f")
latest_data = JSON.parse(latest)
latest_id = latest_data["id"]

genre = RestClient.get("https://api.themoviedb.org/3/genre/movie/list?api_key=f7aed4cdd4714e239a74cd8b6e37e07f&language=en-US")
genre_data = JSON.parse(genre)
genre_data["genres"].each do |genre|
    Genre.create(name: genre["name"], genre_id: genre["id"])
end

    url = "https://api.themoviedb.org/3/movie/popular?api_key=f7aed4cdd4714e239a74cd8b6e37e07f"
resp = RestClient.get(url)

data = JSON.parse(resp)


 data["results"].each do |movie|
 #:title, :year, :rated, :released, :runtime, :rating, :box_office,
    Movie.create(title: movie["title"], runtime: movie["runtime"], released: movie["release_date"], rating:  movie["vote_average"], budget: movie["budget"],box_office: movie["revenue"])


        resp_actor = RestClient.get("https://api.themoviedb.org/3/movie/#{movie["id"].to_s}/credits?api_key=f7aed4cdd4714e239a74cd8b6e37e07f")
        actor_data = JSON.parse(resp_actor)

        actor_data["cast"].each do |actor|
                if !(Actor.names.include?(actor["name"]))
            Actor.create(name: actor["name"])
         end 
        end 
        movie["genre_ids"].each do |id|
            GenresMovie.create(movie_id: find_movie_id(movie["title"]), genre_id: find_genre_id(id))
        end
        actor_data["cast"].each do |actor|
            ActorMovie.create(actor_id: find_actor_id(actor["name"]), movie_id: find_movie_id(movie["title"]))
    end 
end


update_movie("1917", 119, 368027644, 100000000)
update_movie("Upin & Ipin: Keris Siamang Tunggal", 100, 83857, 4555810)
update_movie("Parasite", 132, 253882759, nil)
update_movie("Ant-Man and the Wasp", 118, 622674139, 162000000)
update_movie("F#*@BOIS", 80, nil, nil)
update_movie("Dolittle", 101, 227908130, 175000000)
update_movie("Ad Astra", 123, 132807427, 87500000)
update_movie("Birds of Prey (and the Fantabulous Emancipation of One Harley Quinn)",109,199158461,84500000)
update_movie("The Invisible Man",125,122914050,84500000)
update_movie("Star Wars: The Rise of Skywalker",142,1074144248,200000000)
update_movie("Onward", 102,103181419, 135000000)
update_movie("Bloodshot",109,28428855,45000000)
kamen = "Kamen Rider Zi-O NEXT TIME: Geiz, Majesty"
kamen.update(runtime: 64)
update_movie("Sonic the Hedgehog", 99, 306766470, 85000000)
update_movie("Jumanji Next Level", 123, 796575993, 125000000)
update_movie("Frozen 2", 103, 1450026933, 150000000)
update_movie("Contagion", 106, 136515867, 60000000)
update_movie("Joker", 122, 1074251311, 55000000)
update_movie("The Hunt", 90, 6512500, 14000000)
update_movie("Kanunum Kanunum Kollaiyadithaal", 160, 14829, nil)
