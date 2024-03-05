# frozen_string_literal: true

module StudentsHelper
  def display_social_media_link(user, media_type)
    case media_type
    when :instagram
      link_to(image_tag('instagram_icon.png'), user.instagram_url, target: '_blank') if user.instagram_url.present?
    when :twitter
      link_to(image_tag('twitter_icon.png'), user.x_url, target: '_blank') if user.twitter_url.present?
    when :facebook
      link_to(image_tag('snapchat_icon.png'), user.snap_url, target: '_blank') if user.facebook_url.present?
      # Add additional social media types as needed
    end
  end
end
