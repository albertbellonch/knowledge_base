ActionMailer::Base.smtp_settings = {
  :address              => APP_CONFIG['mail']['smtp']['address'],
  :port                 => APP_CONFIG['mail']['smtp']['port'],

  :domain               => APP_CONFIG['mail']['smtp']['domain'],
  :user_name            => APP_CONFIG['mail']['account']['user_name'],
  :password             => APP_CONFIG['mail']['account']['password'],
  :authentication       => :plain,
  :enable_starttls_auto => true
}
