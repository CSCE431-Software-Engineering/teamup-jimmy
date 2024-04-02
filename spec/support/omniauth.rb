RSpec.configure do |config|
    config.before(:each, type: :system) do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: 'google_oauth2',
        uid: '123456789',
        info: {
          email: 'testuser@tamu.edu',
          name: 'Test User',
          first_name: 'Test',
          last_name: 'User',
        },
        credentials: {
          token: 'mock_token',
          refresh_token: 'mock_refresh_token',
          expires_at: Time.now + 1.week,
          expires: true
        }
      })
    end
  end
  