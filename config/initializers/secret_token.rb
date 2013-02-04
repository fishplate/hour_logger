# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
string = ""
30.times {string += (("a".."z").to_a << ("1".."30").to_a).flatten.sample}
MYAPP::Application.config.secret_token = string