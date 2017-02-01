class Article < ApplicationRecord

  include AASM

  #Tabla => Articles
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, length: { minimum: 10}

  # Funcionalidad de paperClip
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  # Relacion 1 - 0..*
  has_many :has_categories
  has_many :categories, through: :has_categories
  has_many :comments

  # Relacion 0..* - 1
  belongs_to :user

  # Ejecuciones que se realizan antes del guardado
  before_save :set_visits_count

  # Ejecuciones que se realizan despues de la creacion
  after_create :save_categories

  # Ejecuciones que se realizan antes de la actualizacion
  # before_update :clear_categories
  # after_update :save_categories

  # Ejecuciones que se realizan despues de la eliminacion
  before_destroy :clear_categories

  scope :publicados, ->{ where(state: "published") }

  scope :ultimos, ->{ order("created_at DESC") }

  # Igual que el scope, es una peculiaridad de rails
  # def self.publicados
  #   Article.where(state: "published")
  # end

  # Custom setter
  def categories=(value)
    @categories = value
  end

  def update_visits_count
    #self.save if self.visits_count.nil?
    self.update(visits_count: self.visits_count + 1)
  end

  aasm column: "state" do
    state :in_draft, initial: true
    state :published

    event :publish do
      transitions from: :in_draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :in_draft
    end
  end

  # Metodos privados
  private

  def clear_categories
    hasCategories = HasCategory.where(article_id: self.id)
    hasCategories.each do |h|
      HasCategory.destroy(h)
    end
  end

  def save_categories
    unless @categories.nil?
      @categories.each do |category_id|
        HasCategory.create(category_id: category_id, article_id: self.id)
      end
    end
  end

  def set_visits_count
    # Pone el valor del contador de visitas a 0 si el valor es nulo ('||=')
    self.visits_count ||= 0
  end

end
