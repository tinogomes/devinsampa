# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_devinsampa_session',
  :secret      => 'a1fa0369779a00fd3eabbba188fe28c1b941a188feaecc21314cef3c6fdfd70f807ffdf613732ab87cfd0f74a65a588245e27b93ee3e40d8bb2edd745c389a52'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
