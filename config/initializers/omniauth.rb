Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '152474741590983', 'a5e319cb42100acfa94532bd9b0f701d',
           :scope => 'email,read_stream', :display => 'popup'
end