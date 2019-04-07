require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

require('pry-byebug')


customer1 = Customer.new({'name' => 'John', 'cash' => 20})
customer1.save()
customer2 = Customer.new({'name' => 'Claire', 'cash' => 25})
customer2.save()

film1 = Film.new({'title' => 'Captain Marvel', 'price' => 12})
film1.save()
film2 = Film.new({'title' => 'Dumbo', 'price' => 11})
film2.save()

screening1 = Screening.new({'film_id' => film1.id, 'start_time' => '19:00'})
screening1.save()
screening2 = Screening.new({'film_id' => film1.id, 'start_time' => '20:00'})
screening2.save()
screening3 = Screening.new({'film_id' => film2.id, 'start_time' => '22:00'})
screening3.save()

ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer1.id, 'screening_id' => screening1.id})
ticket1.save()
ticket2 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer2.id, 'screening_id' => screening3.id})
ticket2.save()
ticket3 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer2.id, 'screening_id' => screening2.id})
ticket3.save()
ticket4 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer2.id, 'screening_id' => screening2.id})
ticket4.save()


binding.pry

nil
