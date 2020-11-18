class User < ApplicationRecord

  enum gender: { male:0, female:1, other:2}
=begin
  enum admin: [ :user, :admin, :super_admin ]
=end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shipping_address
  has_many :invoices
end
