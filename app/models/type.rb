class Type < ApplicationRecord
  has_many :followers, :dependent => :destroy

  validates :name, :presence => true

end
