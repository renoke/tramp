require 'activesupport'  
class Money
  include Comparable
  
  cattr_accessor :default_currency
  @@default_currency = "EUR"

  attr_reader :amount, :currency

  
  def self.convert(args)
    case args
    when Numeric  then Money.new(args)
    when String   then Money.new(Float(args))
    when Array    then Money.new(*args)
    when Hash     then Money.new(args[:amount], args[:currency])
    end
  end
  
  def self.construct(amount, currency = @@default_currency)
    Money.new((amount/100),currency)
  end

  class MoneyError < StandardError# :nodoc:
  end

  def initialize(amount, currency = @@default_currency)
    @amount, @currency = (amount*100).round, currency
  end
  
  def eql?(other_money)
    amount == other_money.amount && currency == other_money.currency
  end

  def <=>(other_money)
    if currency == other_money.currency
      amount <=> other_money.amount
    else
      amount <=> other_money.exchange_to(currency).amount
    end
  end

  def +(other_money)
    return other_money.dup if amount.zero? 
    return dup if other_money.amount.zero?

    if currency == other_money.currency
      Money.new(amount + other_money.amount, other_money.currency)
    else
      Money.new(amount + other_money.exchange_to(currency).amount,currency)
    end   
  end

  def -(other_money)
    return other_money.dup if amount.zero? 
    return dup if other_money.amount.zero?

    if self.amount == 0 or currency == other_money.currency
      Money.new(amount - other_money.amount, other_money.currency)
    else
      Money.new(amount - other_money.exchange_to(currency).amount, currency)
    end   
  end

  # get the amount value of the object
  def amount
    @amount.to_i
  end

  # multiply money by fixnum
  def *(fixnum)
    Money.new(amount * fixnum, currency)    
  end

  # divide money by fixnum
  def /(fixnum)
    Money.new(amount / fixnum, currency)    
  end
  
  # Test if the money amount is zero
  def zero?
    amount == 0 
  end

  def to_s
    sprintf("%.2f", amount.to_f / 100  )
  end
  
  def to_cents
    amount
  end
  
  alias to_i to_cents
  
  def to_f
    (amount/100).to_f
  end 

  def self.empty(currency = @@default_currency)
    Money.new(0, currency)
  end

  def self.euro(num)
    Money.new(num, "EUR")
  end
  
  def inspect
    "@amount= #{@amount}"
  end
 
end