class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :document, :name, :lastname, :phone, :role

  validates :email, uniqueness: { case_sensitive: false }

  validates :document, uniqueness: { case_sensitive: false }

end
