require_relative 'account'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

def fetch_accounts
  accounts = {}
  accounts['business checking'] = Account.new('Business Checking')
  accounts['purchasing account'] = Account.new('Purchasing Account')
  accounts
end

def fetch_account(account_name)
  Account.new(account_name)
end

get '/' do
  redirect '/accounts'
end

get '/accounts' do

  @accounts = fetch_accounts

  erb :accounts
end

get '/accounts/:account_name' do
  @account_name = params[:account_name].split('+').map(&:capitalize).join(' ')
  @account = fetch_account(@account_name)
  erb :account
end
