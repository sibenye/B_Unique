# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_B_UniqueV_session',
  :secret      => 'a0e385fc30d1bd608a3fd6e7609a57ee5f666a7b0b86073264700ae42a4ba6b1cb65f8129d39e118b3d364318066ba48578f02e6c56ffb39767bd86446226d33'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
