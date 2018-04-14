require_relative('Models/customer.rb')
require_relative('Models/film.rb')
require_relative('Models/ticket.rb')

require( 'pry-byebug' )

# Ticket.delete_all()
# Film.delete_all()
# Customer.delete_all()


customer_1 = Customer.new({ 'first_name' => 'Morgan', 'last_name' => 'Freeman', 'funds' => 80})
customer_1.save()
customer_2 = Customer.new({ 'first_name' => 'Maria', 'last_name' => 'Anjelo', 'funds' => 50})
customer_2.save()
customer_3 = Customer.new({ 'first_name' => 'John', 'last_name' => 'Mayor', 'funds' => 100})
customer_3.save()

film_1 = Film.new({ 'title' => 'Matrix', 'price' => 12})
film_1.save()
film_2 = Film.new({ 'title' => 'Matrix2', 'price' => 13})
film_2.save()

ticket_1 = Ticket.new({ 'customer_id' => customer_1.id, 'film_id' => film_1.id})
ticket_1.save()
ticket_2 = Ticket.new({ 'customer_id' => customer_3.id, 'film_id' => film_1.id})
ticket_2.save()
ticket_3 = Ticket.new({ 'customer_id' => customer_1.id, 'film_id' => film_2.id})
ticket_3.save()
ticket_4 = Ticket.new({ 'customer_id' => customer_2.id, 'film_id' => film_2.id})
ticket_4.save()

binding.pry
nil
