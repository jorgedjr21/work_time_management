class User < ApplicationRecord
  has_many :work_histories

  validates :name, presence: true, allow_blank: false
  validates :email, uniqueness: { case_sensitive: false }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
end
