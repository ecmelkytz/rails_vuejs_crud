class Book < ApplicationRecord
  default_scope { order( created_at: :asc) }

  validates :title, presence: true
end
