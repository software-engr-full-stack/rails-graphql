class User < ApplicationRecord
  has_many :resources, dependent: :destroy
end
