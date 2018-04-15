require('pg')
require_relative('customer.rb')
require_relative('film')
require_relative('ticket')
require_relative('../db/sql_runner.rb')

class Ticket


  attr_reader :id
  attr_accessor :film_id, :customer_id
  def initialize(options)
    @id = options['id'].to_i
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end


  def save()
    sql = "INSERT INTO ticket
    (
      film_id,
      customer_id

    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@film_id, @customer_id]
    ticket = SqlRunner.run( sql, values ).first
    @id = ticket['id'].to_i
  end

  

  def self.all()
    sql = "SELECT * FROM ticket"
    values = []
    ticket = SqlRunner.run(sql, values)
    result =Ticket.map_ticket(ticket)
    return result
  end



  def self.delete_all()
    sql = "DELETE FROM ticket"
    values = []
    SqlRunner.run(sql, values)
  end



  def film()
    sql = "SELECT * FROM film WHERE id = $1"
    values = [@film_id]
  film_hash = SqlRunner.run(sql, values).first()
  return Film.new(film_hash)
  end



  def customer()
    sql = "SELECT * FROM customer WHERE id = $1"
    values = [@customer_id]
  customer_hash = SqlRunner.run(sql, values).first()
    return Customer.new(customer_hash)
  end

end
