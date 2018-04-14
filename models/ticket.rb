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
    @customer_id = options['customer_id'].to.i
  end


  def save()
    sql = "INSERT INTO tickets
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
    visit = SqlRunner.run( sql,values ).first
    @id = visit['id'].to_i
  end
end
