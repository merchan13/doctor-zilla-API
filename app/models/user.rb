class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  validates_presence_of :email, :document, :name, :lastname, :phone, :role
  validates_uniqueness_of :email, :document

  # Historias médicas
  has_many :medical_records
  # Asistentes
  has_many :assistantships
  has_many :assistants, through: :assistantships

  def full_name
    return "#{name.split(' ')[0]} #{lastname}".strip if (name || lastname)
    "Anonymous"
  end

  def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(auth_token: token)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil)
  end

  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end

end
