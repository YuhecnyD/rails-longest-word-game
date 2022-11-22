require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    # generate random grid of letters
    @letters = []
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end
  def score
    @result = ''
    # in_grid = params[:letters]
    # @result = in_grid
    in_grid = params[:word].chars.all? { |letter| params[:word].count(letter) <= params[:letters].count(letter) }
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    if in_grid == false
      @result = "Sorry but #{params[:word]} can't be built out of #{@letters}"
    elsif json['found'] == false
      @result = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{params[:word]} is a valid English word!"
    end
  end
end
