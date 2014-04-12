class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates_presence_of :body


  scope :ordered_by_creation, -> { order("created_at DESC")}
end
