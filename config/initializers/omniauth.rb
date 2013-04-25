Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOKAPPID'], ENV['FACEBOOKAPPSECRET'],
           :scope => 'email,read_stream', :display => 'popup'
end