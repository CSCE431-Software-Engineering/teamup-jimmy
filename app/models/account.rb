class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    account = find_or_initialize_by(email: email)

    if email =~ /@tamu.edu\z/
      account.update(uid: uid, full_name: full_name, avatar_url: avatar_url) unless account.persisted?
      account
    else
      nil
    end
  end
end