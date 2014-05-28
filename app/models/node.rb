class Node < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :total_visits, numericality: { greater_than_or_equal_to: 0 }

  def probability_hash
    Hash[Path.where(begin_node_id: id).map { |x| [x.end_node_id, x.total_traversals.to_f/total_visits]}]
  end

  def combined_probability prev_hash
    combined = probability_hash.keep_if { |k, v| prev_hash.has_key? k } # use slice!
    normalized combined.each_key { |k| combined[k] *= prev_hash[k]}
  end

  def normalized h
    normalizing_constant = h.values.inject(:+)
    h.each_key { |k| h[k] /= normalizing_constant}
  end
end
