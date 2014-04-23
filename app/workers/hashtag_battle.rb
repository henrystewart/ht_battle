require 'twitter'

module HashtagBattle


  @queue = :battle_queue
  CONST_TIMEOUT = 10 # keep connection open with Timeout length

  def self.perform(id, brand_1, brand_2)
    # create obj that will connect to Twitter streaming API
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "AJrghs2Q74I09aAUAoegK3t6G"
      config.consumer_secret     = "tK2YdY8ACrYSgtUb50z2N8gbYFK2iGar6mYMuLztZQGxaahkDe"
      config.access_token        = "351152791-gSBD8CXSKOaj3rs2cYNEOkVjBVkzrq7VpF9v9lvG"
      config.access_token_secret = "61lJYCMJ8DP8NlanYoQR8cevIGInHKpOtblKYLxD5ibeI"
    end


    topics = ["#{brand_1}" ,"#{brand_2}"]
    brand_1_count = 0
    brand_2_count = 0

    # actually get #word, so prepend hashtag
    brand_1_name = '#' + topics[0]
    brand_2_name = '#' + topics[1]

    #TODO: log this properly
    # puts brand_1_name
    # puts brand_2_name


    begin 
      # poll streaming API until timeout
      Timeout::timeout(CONST_TIMEOUT) do 
        client.filter(:track => topics.join(',')) do |object|
          puts object.text if object.is_a?(Twitter::Tweet) && object.text.include?(brand_1_name) || object.text.include?(brand_2_name)
          if object.text.include?(brand_1_name)
            brand_1_count += 1
          end
          if object.text.include?(brand_2_name)
            brand_2_count += 1
          end

        end
      end
    rescue Exception => e

      # TODO: Log this for internal use.
      #puts "catching time out error"
      
      battle = Battle.find_by_id(id)
      battle.brand_1_count += brand_1_count
      puts battle.brand_1_count
      battle.brand_2_count += brand_2_count

      battle.save!

      retry if battle.running == true
    end

  end




end

