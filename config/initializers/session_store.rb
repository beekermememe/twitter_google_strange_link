# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_searchit_easy_session',
  :secret      => '5d1ec99d98647ec2b3acd895396cbacdcf4cc16a7e6df3fedcb3f46836cb7666fa32e9b7d9a443b4f4845c8701ed58cdd031bf8dfd64836196b88dc005f6965f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
