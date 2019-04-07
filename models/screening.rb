require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')

class Screening

  attr_reader :id, :film_id, :start_time, :capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @start_time = options['start_time']
    @capacity = 100
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

  def check_at_capacity
    sql = "SELECT screenings.* FROM screenings INNER JOIN tickets on screenings.id = tickets.screening_id WHERE screenings.id = $1"
    value = [@id]
    number = Sqlrunner.run(sql, value)
    if number.count() == @capacity
      return "No more tickets available"
    else
      return "More seat available"
    end
  end



end
