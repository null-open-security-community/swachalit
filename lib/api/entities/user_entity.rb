module API
  class UserEntity < Grape::Entity
    expose :id, documentation: { type: Integer, desc: 'User ID' }
    expose :name, documentation: { type: String, desc: 'User name' }
    expose :profile_url do |user, option|
      Rails.application.routes.url_helpers.public_profile_url(user)
    end
    expose :avatar_url do |user, option|
      user.avatar.url
    end
  end
end
