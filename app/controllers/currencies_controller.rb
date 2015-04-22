class CurrenciesController < ApplicationController

  def index
    @currencies = Currency.order(created_at: :desc)
  end
end
