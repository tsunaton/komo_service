class MatchingsController < ApplicationController
  def index
    @matchings = Matching.all
  end

  def create
  end


end
