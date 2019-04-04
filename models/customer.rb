require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :cash

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @cash = options['cash'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (
      name, cash
      )
      VALUES
      (
      $1, $2
      )
      RETURNING id"
      values = [@name, @cash]
      user = Sqlrunner.run(sql, values)[0]
      @id = user['id'].to_i
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    results = Sqlrunner.run(sql)
    return results.map { |customer| Customer.new(customer)  }
  end

  def update()
    sql = "UPDATE customers SET (name, cash) = ($1, $2) WHERE id = $3"
    values = [@name, @cash, @id]
    Sqlrunner.run(sql, values)
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    Sqlrunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    result = Sqlrunner.run(sql, values)
    return result.map { |film| Film.new(film)  }
  end


end
