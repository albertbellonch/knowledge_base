Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'vsOnHIt9xjsx0EmorrYQjw', 'ejseEI5is2TbWgUfC5rudN1eHAV2PiqkRUw7InBJ0lE'
  provider :facebook, '35bc3a6091a4172c4026a1ae206a726e', '4adea7fcca33ff57673e83b746ab61b8', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end
