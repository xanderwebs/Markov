class Path < ActiveRecord::Base
  def begin_node
    Node.find(begin_node_id)
  end

  def end_node
    Node.find(end_node_id)
  end
end
