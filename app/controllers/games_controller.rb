require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    if allletters(@word.upcase, @grid)
      if engword(@word)
        @score = "congrats"
      else
        @score = "Word is not an english word or didn't use correct letters"
      end
    else
      @score = "Not in the grid"
    end
  end

  private

  def allletters(word, grid)
    if word.chars.all? { |letter| word.count(letter) <= grid.split.count(letter) }
  end

  def engword(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
end

