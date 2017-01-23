class Article < ApplicationRecord

  #Tabla => Articles
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, length: { minimum: 10}

  # Funcionalidad de paperClip
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  # Relacion 1 - 0..*
  has_many :comments

  # Relacion 0..* - 1
  belongs_to :user

  # Ejecuciones que se realizan despues del guardado
  before_save :set_visits_count

  def update_visits_count
    #self.save if self.visits_count.nil?
    self.update(visits_count: self.visits_count + 1)
  end

  # Metodos privados
  private
  def set_visits_count
    # Pone el valor del contador de visitas a 0 si el valor es nulo ('||=')
    self.visits_count ||= 0
  end

end
