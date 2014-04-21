require 'twitter'

module HashtagBattle

  @@counter = 1

  @queue = :battle_queue

  #TODO: put topics as parameters
  #TODO: battle as parameter?
  #TODO: prevent nil from being passed
  #TODO: find by battle id
  def self.perform(id)

    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "AJrghs2Q74I09aAUAoegK3t6G"
      config.consumer_secret     = "tK2YdY8ACrYSgtUb50z2N8gbYFK2iGar6mYMuLztZQGxaahkDe"
      config.access_token        = "351152791-gSBD8CXSKOaj3rs2cYNEOkVjBVkzrq7VpF9v9lvG"
      config.access_token_secret = "61lJYCMJ8DP8NlanYoQR8cevIGInHKpOtblKYLxD5ibeI"
    end

    topics = ['coffee', 'football']
    coffee_count = 0
    football_count = 0
    coffee = 'coffee'
    football = 'football'

    since_id = Time.now.to_s

    begin 
      Timeout::timeout(15) do #TODO get rid of this & change to "running" or other boolean
        client.filter(:track => topics.join(',')) do |object|
          # puts object.text if object.is_a?(Twitter::Tweet)
          puts object.text if object.is_a?(Twitter::Tweet) && object.text.include?("\#football") || object.text.include?("\#coffee")
          if object.text.include?('#football')
            football_count += 1
          end
          if object.text.include?('#coffee')
            coffee_count += 1
          end
        end
      end
    rescue Exception => e #TODO catch other errors
      puts "catching time out error"
      # next
    end

    puts ""
    puts "coffee count: #{coffee_count}"
    puts "football count: #{football_count}"

    # write battle to db
    battle = Battle.new(:name => "#{coffee} vs. #{football}", :brand_1_hashtag => coffee, :brand_1_count => coffee_count, :brand_2_hashtag => football, :brand_2_count => football_count)
    battle.save!

    # proper dismount from the Resque queue


  end

  def self.counter
    return @@counter
  end




end


# require 'twitter'

# module HashtagBattle

#   def self.get_stream()

#     client = Twitter::Streaming::Client.new do |config|
#       config.consumer_key        = "AJrghs2Q74I09aAUAoegK3t6G"
#       config.consumer_secret     = "tK2YdY8ACrYSgtUb50z2N8gbYFK2iGar6mYMuLztZQGxaahkDe"
#       config.access_token        = "351152791-gSBD8CXSKOaj3rs2cYNEOkVjBVkzrq7VpF9v9lvG"
#       config.access_token_secret = "61lJYCMJ8DP8NlanYoQR8cevIGInHKpOtblKYLxD5ibeI"
#     end

#     client.sample do |object|
#       puts object.text if object.is_a?(Twitter::Tweet)
#     end

#   end
# end