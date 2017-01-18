class Article < ApplicationRecord

  #Tabla => Articles
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, length: { minimum: 10}

  # Relacion 0..* - 1
  belongs_to :user
end
