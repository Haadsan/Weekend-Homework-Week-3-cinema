require_relative('customer.rb')
require_relative('film.rb')
require_relative('ticket.rb')
require_relative('../db/sql_runner.rb')

require( 'pry-byebug' )


class Customer


  attr_reader :id
  attr_accessor :first_name, :last_name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @first_name = options['first_name']
    @last_name = options['last_name']
    @funds = options['funds'].to_i
  end



  def save()
    sql = "INSERT INTO customer
    (first_name,last_name,funds) VALUES($1, $2, $3)RETURNING id"
    values = [@first_name, @last_name, @funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i

  end


  def self.all()
    sql = "SELECT * FROM customer"
    values = []
    customer = SqlRunner.run(sql, values)
    result =Customer.map_customer(customer)
    return result
  end

  def self.map_customer(customer_data)
    # pass the result of data query()
    return customer_data.map{|customer_hash| Customer.new(customer_hash)}
  end


  def update()
    sql = "UPDATE customer SET (first_name, last_name, funds) = ($1, $2, $3) WHERE id = $4;"
    values = [@first_name, @last_name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM customer WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end



  def self.delete_all()
    sql = "DELETE FROM customer"
    values = []
    SqlRunner.run(sql, values)
  end


  def film()
    sql = "SELECT film.* FROM film INNER JOIN ticket ON film.id = ticket.film_id WHERE ticket.customer_id = $1"
    values = [@id]
    film = SqlRunner.run(sql, values)
    return film.map {|film_hash| Film.new(film_hash)}
  end

  def buy_ticket(ticket)
    if sufficient_funds?(ticket)
      @funds -= ticket.price()
    end

    def sufficient_funds?(ticket)
      return @funds >= ticket.price()
    end

  end

end
