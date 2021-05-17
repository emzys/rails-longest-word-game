require 'open-uri'

class GamesController < ApplicationController
  def new
    vowels = %w(A E I O U Y)
    charset = ('A'..'Z').to_a
    @letters = Array.new(4) { vowels.sample }
    @letters += Array.new(6) { (charset - vowels).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    # p @letters
    @answer = (params[:answer] || '').upcase
    # p @answer
    @in_grid = word_in_grid?(@answer, @letters)
    @english_word = word_valid?(@answer)
  end

  def word_in_grid?(answer, letters)
    answer.chars.all? { |letter| answer.count(letter) <= letters.count(letter) }
  end

  def word_valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    @word_specs = JSON.parse(word_serialized)
    @word_specs['found']
  end
end
