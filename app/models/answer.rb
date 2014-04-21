class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates_presence_of :body

  before_save :capitalize_body

  scope :ordered_by_creation, -> { order("created_at DESC")}

  private

  def capitalize_body
    self.body = self.body.capitalize
  end

end
