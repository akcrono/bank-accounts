require_relative 'account'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'



def get_accounts
  accounts = {}
  accounts['business checking'] = Account.new('Business Checking')
  accounts['purchasing account'] = Account.new('Purchasing Account')
  accounts
end

def get_account account_name
  temp = Account.new(account_name)
  return temp
end

get '/' do
  redirect '/accounts'
end

get '/accounts' do

  @accounts = get_accounts

  erb :accounts
end

get '/accounts/:account_name' do
  @account_name = params[:account_name].split('+').map(&:capitalize).join(' ')
  @account = get_account(@account_name)
  # binding.pry
  erb :account
end
