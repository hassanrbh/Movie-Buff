# Movie Buff

### For this project you will be writing ActiveRecord queries against the actors, movies, and castings tables from the SQL Zoo project. We've written rspec tests to ### check that you both return the correct results and query the database the correct number of times. Please run them to check your work.

# Learning Goals :

## Be able to write complicated ActiveRecord queries
## Become familiar with more of ActiveRecord's functionalities
## Know how to test and debug ActiveRecord queries

# Setup :

First make sure Postgres is running.

Then download the skeleton. Run bundle install and ./setup to populate the database.

If you'd like to run specs for a particular problem, simply append the corresponding line number to the spec file you want to run.

-> bundle exec rspec spec/01_queries_spec.rb:66

You'll be working in the skeleton/movie_buff/ folder. Do the problems in 01_queries.rb before moving on to 02_queries.rb and then 03_queries.rb. Information on the tables you will be working with can be found below:

 == Schema Information

 Table name: actors

  id          :integer      not null, primary key
  name        :string

 Table name: movies

  id          :integer      not null, primary key
  title       :string
  yr          :integer
  score       :float
  votes       :integer
  director_id :integer

 Table name: castings
 
  id          :integer      not null, primary key
  movie_id    :integer      not null
  actor_id    :integer      not null
  ord         :integer
