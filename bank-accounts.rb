require_relative 'account'
require 'sinatra'
require 'sinatra/reloader'



def get_accounts
  accounts = {}
  accounts['business checking'] = Account.new('Business Checking')
  accounts['purchasing account'] = Account.new('Purchasing Account')
  accounts
end


get '/' do
  redirect '/accounts'
end

get '/accounts' do

  @accounts = get_accounts

  erb :accounts
end
