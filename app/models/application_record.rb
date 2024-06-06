class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Adjust default sot order
  self.implicit_order_column = :created_at
end
