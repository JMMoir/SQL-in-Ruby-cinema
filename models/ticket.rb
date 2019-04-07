
class Ticket

  attr_accessor :film_id, :customer_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      film_id, customer_id, screening_id
      )
      VALUES
      (
      $1, $2, $3
      )
      RETURNING id"
      values = [@film_id, @customer_id, @screening_id]
      user = Sqlrunner.run(sql, values)[0]
      @id = user['id'].to_i
  end

  def Ticket.all()
    sql = "SELECT * FROM tickets"
    results = Sqlrunner.run(sql)
    return results.map { |ticket| Ticket.new(ticket)  }
  end

  def update()
    sql = "UPDATE tickets SET (film_id, customer_id) = ($1, $2) WHERE id = $3"
    values = [@film_id, @customer_id, @id]
    Sqlrunner.run(sql, values)
  end

  def Ticket.delete_all()
    sql = "DELETE FROM tickets"
    Sqlrunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql, values)
  end

end
