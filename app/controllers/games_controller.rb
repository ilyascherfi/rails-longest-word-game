require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    abc = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << abc.sample
    end
  end

  def score
    @guess = params[:word]
    @letters = params[:letters]
    check = @guess.chars.all? { |letter| @letters.include?(letter) }
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    user = JSON.parse(URI.open(url).read)
    found = user['found']

    if check== false
      @results = "sorry, but #{@guess} can't be made with #{@letters}"
    elsif check && found == false
      @results = "sorry, but #{@guess} does not seem to be a valid English word.."
    else
      @results = "CONGRATULATION! #{@guess} is a valid English word"
    end
  end
end
