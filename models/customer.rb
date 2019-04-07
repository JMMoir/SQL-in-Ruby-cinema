require_relative('../db/sql_runner')
require_relative('film')

class Customer

  attr_reader :id
  attr_accessor :name, :cash, :tickets

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @cash = options['cash'].to_i
    @tickets = []
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
      customer = Sqlrunner.run(sql, values)[0]
      @id = customer['id'].to_i
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

  def film_count()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    result = Sqlrunner.run(sql, values)
    return result.count()
  end


#### map film by id to access ticket price
  def ticket_price(film)
    sql = "SELECT * FROM films WHERE id = $1"
    value = [film.id]
    result = Sqlrunner.run(sql, value)
    price = result.map { |film| Film.new(film).price }
    return price[0].to_i
  end
### method for deducting ticket price
  def charge_for_ticket(price)
    @cash -= price
  end


#### pull methods together to make purchase
  def buy_ticket(film)
    get_price = ticket_price(film)
    charge_for_ticket(get_price)
    @tickets << film
    update()
  end

  ### Check to see how many tickets were bought by customer
  def count_tickets
    return @tickets.length()
  end

end
