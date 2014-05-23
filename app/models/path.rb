class Path < ActiveRecord::Base
  validates :end_node_id, presence: true
  after_create :update_node_visits

  def begin_node
    Node.find(begin_node_id)
  end

  def end_node
    Node.find(end_node_id)
  end

  def update_node_visits
    unless begin_node_id.nil?
      node = begin_node
      node.total_visits += 1
      node.save!
    end
  end
end
