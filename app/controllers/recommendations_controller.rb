class RecommendationsController < ApplicationController

  def index
    @nodes = Node.all
  end

  def show
    path = !params[:previous_ids].nil? ? params[:previous_ids].split('/') : []
    path.push(params[:id]).map! { |x| x.to_i }

    # Sanity Check, @todo: better fix later.
    render(status: 400, json: { errors: 'Bad ID' }) if path.max > Node.all.size

    recommended_nodes = recommended_array generate_probability_hash(path.clone)
    @nodes = recommended_nodes.map {|x| { id: x.first, name: Node.find(x.first).name, score: x.last } }
    @path = path
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
end
