class GamesController < ApplicationController
  def new
    charset = ('A'..'Z').to_a
    @letters = Array.new(10) { charset.sample }
  end

  def score
  end
end
