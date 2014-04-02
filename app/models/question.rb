class Question < ActiveRecord::Base

  validates :title, presence: {message: "must be there"}, uniqueness: true

  validates_presence_of :description, message: "must be present"

  default_scope { order("title ASC") }

  has_many :answers, dependent: :destroy

  scope :recent, lambda {|x| order("created_at DESC").limit(x) }
  # def self.recent(x)
  #   order("created_at DESC").limit(x)
  # end

  scope :recent_ten, lambda { order("created_at DESC").limit(10) }
  # def self.recent_ten
  #   order("created_at DESC").limit(10)
  # end

  scope :after, lambda {|date| where(["created_at > ?", date]) }

  before_save :capitalize_title

  private

  def capitalize_title
    self.title.capitalize!
  end

end