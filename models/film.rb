require('pg')
require_relative('film.rb')
require_relative('customer.rb')
require_relative('ticket.rb')
require_relative('../db/sql_runner.rb')

class Film


  attr_reader :id
  attr_accessor :title, :price


  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO film
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end



  def self.all()
    sql = "SELECT * FROM film"
    values = []
    film = SqlRunner.run(sql, values)
    result =Film.map_film(film)
    return result
  end

  def self.map_film(film_data)
      # pass the result of data query()
      return film_data.map{|film_hash| Film.new(film_hash)}
    end


  def update()
      sql = "UPDATE film SET (title, price) = ($1, $2) WHERE id = $3;"
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
    end


  def delete()
    sql = "DELETE FROM film WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM film"
    values = []
    SqlRunner.run(sql, values)
  end


  def customer()
    sql = "SELECT customer.* FROM customer INNER JOIN ticket ON customer.id = ticket.customer_id WHERE ticket.film_id = $1"
    values = [@id]
    customer = SqlRunner.run(sql, values)
    return customer.map {|customer_hash| Customer.new(customer_hash)}
  end

end
