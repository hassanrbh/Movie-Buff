def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movies
    .pluck(:id,:title,:year,:score)
    .where(yr: 1980..1989, score: 3..5)    
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  Movies
    .pluck(:yr)
    .group("movies.yr")
    .having("MAX(movies.score) < 8")
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actors
    .select(:id,:title)
    .joins(:movies)
    .where(movies: { title: title })
    .order('castings.ord')
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movies
    .pluck(:title,:id,'actors.name')
    .joins(:actors)
    .where("director_id = actors.id")
    .where(:castings { ord: 1 })
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.
  Actor
    .pluck(:id,:name,'COUNT(castings.actor_id) as supporting_roles')
    .joins(:castings)
    .group('actors.id')
    .where(:castings { ord: > 1 })
    .order("supporting_roles DESC")
    .limit(2)
end
