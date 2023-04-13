class Department < ApplicationRecord
  has_many :employees, dependent: :destroy

  validates :name, presence: true
end
