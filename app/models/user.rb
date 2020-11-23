class User < ApplicationRecord

  enum gender: {male: 0, female: 1, other: 2}
=begin
  enum admin: [ :user, :admin, :super_admin ]
=end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  after_commit :add_default_avatar, only:  [ :create, :update]

  has_many :shipping_addresses
  has_many :invoices


  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "90x90!").processed
    else
      "/default_profile.jpg"
    end
  end



  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
          io: File.open(
              Rails.root.join(
                  'app', 'assets', 'images', 'default_profile.jpg'
              )
          ),
          filename: 'default_profile.jpg',
          content_type: 'image/jpg'
      )
    end
  end


end
