# frozen_string_literal: true

class User < ApplicationRecord
  has_many :books
  has_one_attached :avatar
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = User.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    clean_up_passwords
    update_attributes(params, *options)
  end

  private
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
