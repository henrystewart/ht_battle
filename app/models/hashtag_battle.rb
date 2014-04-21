require 'twitter'

module HashtagBattle

  def self.get_stream()

    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "AJrghs2Q74I09aAUAoegK3t6G"
      config.consumer_secret     = "tK2YdY8ACrYSgtUb50z2N8gbYFK2iGar6mYMuLztZQGxaahkDe"
      config.access_token        = "351152791-gSBD8CXSKOaj3rs2cYNEOkVjBVkzrq7VpF9v9lvG"
      config.access_token_secret = "61lJYCMJ8DP8NlanYoQR8cevIGInHKpOtblKYLxD5ibeI"
    end

    client.sample do |object|
      puts object.text if object.is_a?(Twitter::Tweet)
    end

  end
end