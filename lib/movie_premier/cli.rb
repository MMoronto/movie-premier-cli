#Our CLI Controller

class MoviePremier::CLI 
  
  def call 
    start 
  end 
  
  def list
    puts ""
    puts "****** Coming Soon to a Theatre Near You!!! ******"
    puts ""
    MoviePremier::Movie.all.each.with_index(1) do |movie, i|
      puts "#{i}. #{movie.name}"
    end
    puts ""
  end
  
  def print_movie(movie)
    puts ""
    puts "-------------- #{movie.name} --------------"

    puts ""
    puts movie.summary
    puts ""

    puts "Starring: #{movie.stars}"
    puts ""
  end

  def start
    list
    input = nil
    while input != "exit"
      puts ""
      puts "What movie would you like more information on? Search by name or number."
      puts ""
      puts "Enter list to see the movies again."
      puts "Enter exit to end the program."
      puts ""
      input = gets.strip
      if input == "list"
        list
      elsif input.to_i == 0
        if movie = MoviePremier::Movie.find_by_name(input)
          print_movie(movie)
        end
      elsif input.to_i > 0
        if movie = MoviePremier::Movie.find(input.to_i)
          print_movie(movie)
        end
      end
    end
    puts "Goodbye!!!"
  end
  
end