class Node < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :total_visits, numericality: { greater_than_or_equal_to: 0 }
end
