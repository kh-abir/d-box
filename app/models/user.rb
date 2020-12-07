class User < ApplicationRecord

  enum gender: {male: 0, female: 1, other: 2}
  enum role: {user: 0, admin: 1, super_admin: 2}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_commit :add_default_avatar, only: [:create, :update]

  has_many :shipping_addresses
  has_many :orders
  has_one_attached :avatar


  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "348x354!").processed
    else
      "/default_avatar.png"
    end
  end


  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
          io: File.open(
              Rails.root.join(
                  'app', 'assets', 'images', 'default_avatar.png'
              )
          ),
          filename: 'default_avatar.png',
          content_type: 'image/png'
      )
    end
  end

end
