class RecommendationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @nodes = Node.all
  end

  def show
    path = !params[:previous_ids].nil? ? params[:previous_ids].split('/') : []
    path.push(params[:id]).map! { |x| x.to_i }

    # Sanity Check, @todo: better fix later.
    if sanity_check(path)
      render(status: 400, json: { errors: 'Bad input' })
    else
      recommended_nodes = recommended_array generate_probability_hash(path.clone)
      @nodes = recommended_nodes.map {|x| { id: x.first, name: Node.find(x.first).name, score: x.last } }
      @path = path
    end
  end

  private

  def generate_probability_hash ids
    node_id = ids.pop
    return Node.find(node_id).probability_hash if ids.empty?
    previous_recommendation_hash = generate_probability_hash ids
    Node.find(node_id).combined_probability previous_recommendation_hash
  end

  def recommended_array hash
    hash.to_a.sort{ |x, y| x.last <=> y.last }.reverse
  end

  def sanity_check path
    return true if path.max > Node.all.size
    return true if path.min < 0
    return true unless path.clone.keep_if { |x| y = x.to_i; (y > 0) && y.integer? }.size == path.size
    false
  end
end
