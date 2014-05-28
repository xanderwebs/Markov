class RecommendationsController < ApplicationController
  def index
    @nodes = Node.all
  end

  def show
  end
end
