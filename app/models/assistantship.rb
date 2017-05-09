class Assistantship < ApplicationRecord
  belongs_to :user
  belongs_to :assistant, :class_name => 'User'

  validates_presence_of :user_id, :assistant_id
end
