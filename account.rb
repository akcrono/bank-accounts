require_relative 'transaction'
require 'csv'
require 'pry'

class Account
  attr_reader :account_name, :starting_balance, :current_balance, :transactions

  def initialize(account_name)
    @account_name = account_name
    @starting_balance = load_balance
    @transactions = load_transactions
    @current_balance = calculate_current_balance
  end

  def summary
    transaction_summary = []
    transactions.each do |transaction|
      transaction_summary << transaction.summary
    end
    transaction_summary
  end

  def print
    puts "==== #{account_name} ===="
    puts "Starting Balance: $#{sprintf("%.2f", starting_balance)}"
    puts "Ending Balance:   $#{sprintf("%.2f", current_balance)}\n\n"
    puts summary
    puts "========\n\n"
  end

  def load_balance
    CSV.foreach("balances.csv", headers: true, header_converters: :symbol, :converters => :all) do |row|
      return row[:balance] if row[:account] == account_name
    end
    puts "account not found"
    nil
  end

  def load_transactions
    loaded_transactions = []
    CSV.foreach("bank_data.csv", headers: true, header_converters: :symbol, :converters => :all) do |row|
      if row[:account] == account_name
        loaded_transactions << Transaction.new(row[:amount], row[:description], row[:date])
      end
    end
    loaded_transactions
  end

  def calculate_current_balance

    balance = starting_balance
    transactions.each do |transaction|
      balance += transaction.amount
    end
    balance
  end
end
