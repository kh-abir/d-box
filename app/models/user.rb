class User < ApplicationRecord

  enum gender: [:undisclosed, :female, :male, :other]
  enum admin: [:user, :admin, :super_admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
