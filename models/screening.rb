require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')

class Screening

  attr_reader :id, :film_id, :start_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @start_time = options['start_time']
  end

  def save()
    sql = "INSERT INTO screenings
    (
    film_id, start_time
    )
    VALUES ($1, $2)
    RETURNING id"
    values = [@film_id, @start_time]
    screening = Sqlrunner.run(sql, values)[0]
    @id = screening['id'].to_i
  end

  

end
