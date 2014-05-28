class RecommendationsController < ApplicationController

  def index
    @nodes = Node.all
  end

  def show
    @id = params[:id]
    respond_to do |format|
      format.json
    end
  end
end
