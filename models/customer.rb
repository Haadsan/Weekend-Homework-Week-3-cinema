require('pg')
require_relative('customer.rb')
require_relative('film')
require_relative('ticket')
require_relative('../db/sql_runner.rb')

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
    sql = "INSERT INTO customers
    (
      first_name,
      last_name,
      funds
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@first_name, @last_name, @funds]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end


end
