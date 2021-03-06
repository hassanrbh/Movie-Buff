def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movies.
    .pluck(:id,:title)
    .joins(:actors)
    .where(actors: { name: those_actors })
    .having("COUNT(actors.id) > ?", those_actors.size)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .select("AVG(score), (yr/10) * 10 As decade")
    .group("decade")
    .order("decade ASC")
    .limit(1)
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  subquery =  Movie.select(:id).joins(:actors).where(actors: { name: name })

  Movie
    .joins(:actors)
    .where.not(actors: { name: name })
    .where(movies: { id: subquery })
    .distinct
    .pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .pluck(:name)
    .joins("LEFT OUTER JOIN castings castings.actor_id = actors.id")
    .where(castings: { movie_id: nil })
    .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  query = "#{%whazzername.split(//).joins("%")}%"

  Movie
    .select("movies.*")
    .joins(:actors)
    .where(:name => query)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor
    .pluck(:id,:name,' MAX(actors.yr) - MIN(actors.yr) AS length_of_career')
    .joins(:movies)
    .order('actors.name')
    .group(:id)
    .limit(3)
end
