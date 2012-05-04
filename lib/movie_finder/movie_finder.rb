module MovieFinder

  class MovieFinder

    def find_by_city(city)
      googleMovies = GoogleMovies::Client.new(city)
      movies = Array.new
      if googleMovies.movies_theaters.size > 0
        googleMovies.movies_theaters.each do |theater|
          theater.movies.each do |movie|
            exists = false
            movies.each do |m|
              if movie.name.casecmp(m.title) == 0
                exists = true
                break
              end
            end
            if !exists
              mq = get_movie_details(movie.name)
              if !mq.empty?
                movies << mq
              end
            end
          end
        end
      end

      movies.sort! {|a,b| b.ratings.critics_score <=> a.ratings.critics_score}
      movies
    end

    def find_by_city_for_sms(city)
      parse_response(find_by_city(city))
    end

    def get_movie_details(movie_title)
      RottenTomatoes::Rotten.api_key = "wvw7psh9gt5kn4vf8h9f2bum"
      RottenTomatoes::RottenMovie.find(:title => movie_title, :limit => 1, :expand_results => false)
    end


    def parse_response(movies)
      response = ""
      movies.each do |movie|
        movie_info = "#{movie.title} [AS: #{movie.ratings.critics_score}, CS: #{movie.ratings.audience_score}] "
        if response.length + movie_info.length <160
          response.concat(movie_info)
        end
      end
      response
    end

  end

end