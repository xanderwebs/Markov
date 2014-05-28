class Path < ActiveRecord::Base
  validates :end_node_id, presence: true
  validate :existence_of_end_node, on: [:create]
  validate :uniqueness_of_node_pair, on: [:create]
  after_update :update_node_visits

  def self.find_by_node_pair(b, e)
    find_by(begin_node_id: b, end_node_id: e)
  end

  def self.node_pair_exists?(b, e)
    !find_by_node_pair(b, e).nil?
  end

  def begin_node
    Node.find(begin_node_id)
  end

  def end_node
    Node.find(end_node_id)
  end

  private

  def update_node_visits
    unless begin_node_id.nil?
      node = begin_node
      node.total_visits += 1
      node.save!
    end
  end

  def existence_of_end_node
    node = begin
      Node.find(end_node_id)
    rescue Exception => e
      nil
    end
    if node.nil?
      errors.add(:end_node_existence, "End node does not exist!")
    end
  end

  def uniqueness_of_node_pair
    if Path.node_pair_exists?(begin_node_id, end_node_id)
      errors.add(:path_uniqueness, "Path already exists")
    end
  end
end
