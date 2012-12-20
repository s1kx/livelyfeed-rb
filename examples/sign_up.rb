$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "livelyfeed"

Livelyfeed.configure do |config|
  config.endpoint = ENV['LIVELYFEED_ENDPOINT'] if ENV['LIVELYFEED_ENDPOINT']
  config.consumer_key = ENV['LIVELYFEED_CONSUMER_KEY']
  config.consumer_secret = ENV['LIVELYFEED_CONSUMER_SECRET']
end

client = Livelyfeed::Client.new
client.sign_in_as_client()

result = client.create_user(
  email: "test#{rand(9999)}@gmail.com",
  password: "t3stp4ssw0rd",
  password_confirmation: "t3stp4ssw0rd",
  username: "test#{rand(9999)}",
  first_name: "test",
  last_name: "test",
  location_formatted: "Basle, Switzerland",
  location_places_reference: "CjQqAAAA4blRjzblKZaAzfIfNdnUNxHUmJgqwfWngdfxvKmpDZj27IU0jIRpZ71lSv-HYjUREhD7cV8a8gpetm8uTsqzPl9KGhSLCzXct1jsMWW1xP5hbKPk5sfjTQ"
)
p result