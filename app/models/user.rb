class User < ApplicationRecord
  validates_uniqueness_of :phone_no
  has_many :events
end
