class Path < ActiveRecord::Base
  validates :end_node_id, presence: true
  before_create :uniqueness_of_node_pair
  after_update :update_node_visits

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

  def uniqueness_of_node_pair
    if Path.node_pair_exists?(begin_node_id, end_node_id)
      errors.add(:path_uniqueness, "Path already exists")
    end
  end

  def self.find_by_node_pair(b, e)
    find_by(begin_node_id: b, end_node_id: e)
  end

  def self.node_pair_exists?(b, e)
    !find_by_node_pair(b, e).nil?
  end
end
