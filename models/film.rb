require_relative('../db/sql_runner')
require_relative('customer')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (
      title, price
      )
      VALUES
      (
      $1, $2
      )
      RETURNING id"
      values = [@title, @price]
      film = Sqlrunner.run(sql, values)[0]
      @id = film['id'].to_i
  end

  def Film.all()
    sql = "SELECT * FROM films"
    results = Sqlrunner.run(sql)
    return results.map { |film| Film.new(film)  }
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    Sqlrunner.run(sql, values)
  end

  def Film.delete_all()
    sql = "DELETE FROM films"
    Sqlrunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql, values)
  end

### See which customers are going to see each film
  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    result = Sqlrunner.run(sql, values)
    return result.map { |customer| Customer.new(customer)  }
  end

### Check to see how many customer are going to watch a certain film
  def customers_count()
      sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
      values = [@id]
      result = Sqlrunner.run(sql, values)
      return result.count()
  end

  def most_popular_start_time()
    sql = "SELECT COUNT(screenings.film_id), screenings.start_time FROM screenings INNER JOIN tickets ON screenings.id =tickets.screening_id WHERE screenings.film_id = $1 GROUP BY screenings.start_time ORDER BY screenings.start_time DESC LIMIT 1"
    value = [@id]
    return Sqlrunner.run(sql, value)[0]['start_time']
  end

end
