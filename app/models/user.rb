class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  after_commit :add_default_avatar, only: [:create, :update]

  enum gender: {male: 0, female: 1, other: 2}
  enum role: {user: 0, admin: 1, super_admin: 2}

  has_many :shipping_addresses
  has_many :orders
  has_one_attached :avatar
  after_create :send_confirmation_mail

  def send_confirmation_mail
    self.send_confirmation_instructions
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "348x354!").processed
    else
      "/profile.png"
    end
  end


  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
          io: File.open(
              Rails.root.join(
                  'app', 'assets', 'images', 'profile.png'
              )
          ),
          filename: 'profile.png',
          content_type: 'image/png'
      )
    end
  end

end
