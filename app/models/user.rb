class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :document, :name, :lastname, :phone, :role
  validates_uniqueness_of :email, :document

  has_many :user_medical_records
  has_many :medical_records, through: :user_medical_records

  def full_name
    return "#{name.split(' ')[0]} #{lastname.split(' ')[0]}".strip if (name || lastname)
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

end
