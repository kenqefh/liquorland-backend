class Review < ApplicationRecord
  belongs_to :user
  belongs_to :drink, counter_cache: :reviews_count

  validates :comment, presence: true, length: {maximum: 140}
  validates :rating,  inclusion: { in: 0..5, message: 'Should be between 0 and 5' },
                      allow_nil: true
  
end
