class Node < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :total_visits, numericality: { greater_than_or_equal_to: 0 }

  def generate_probability_hash
    # Hash[Path.where(begin_node_id: id).map { |x| [x.id, ]}
  end
end
