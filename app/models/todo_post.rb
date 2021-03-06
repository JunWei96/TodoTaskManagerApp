class TodoPost < ApplicationRecord
  acts_as_taggable
  acts_as_taggable_on :category
  belongs_to :user, required: false

  before_save :set_tag_owner

  default_scope -> { order(due_date: :asc) }

  validates :user_id, presence: true
  validates :description, presence: true, length: {maximum: 140}

  def set_tag_owner
    set_owner_tag_list_on(self.user, :category, self.tag_list)
    # Clear the list so we don't get duplicate taggings
    self.tag_list = nil
  end

  def completed?
		!completed_at.blank?
	end
end
