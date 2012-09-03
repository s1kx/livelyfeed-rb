$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "livelyfeed"

Livelyfeed.configure do |config|
	config.endpoint = ENV['LIVELYFEED_ENDPOINT'] if ENV['LIVELYFEED_ENDPOINT']
	config.consumer_key = ENV['LIVELYFEED_CONSUMER_KEY']
	config.consumer_secret = ENV['LIVELYFEED_CONSUMER_SECRET']
end

username = ARGV[0] || ENV['LIVELYFEED_USERNAME']
password = ARGV[1] || ENV['LIVELYFEED_PASSWORD']

client = Livelyfeed::Client.new
client.sign_in_with_credentials(username, password)

p client.get('/v1/users/1')
