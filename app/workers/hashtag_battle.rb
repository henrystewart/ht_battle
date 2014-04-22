require 'twitter'

module HashtagBattle

  @@counter = 1

  @queue = :battle_queue


  def self.perform(id, brand_1, brand_2)
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "AJrghs2Q74I09aAUAoegK3t6G"
      config.consumer_secret     = "tK2YdY8ACrYSgtUb50z2N8gbYFK2iGar6mYMuLztZQGxaahkDe"
      config.access_token        = "351152791-gSBD8CXSKOaj3rs2cYNEOkVjBVkzrq7VpF9v9lvG"
      config.access_token_secret = "61lJYCMJ8DP8NlanYoQR8cevIGInHKpOtblKYLxD5ibeI"
    end


    topics = ["#{brand_1}" ,"#{brand_2}"]
    brand_1_count = 0
    brand_2_count = 0
    brand_1_name = '#' + topics[0]
    brand_2_name = '#' + topics[1]

    puts brand_1_name
    puts brand_2_name


    begin 
      Timeout::timeout(3) do #TODO get rid of this & change to "running" or other boolean
        client.filter(:track => topics.join(',')) do |object|
          # puts object.text if object.is_a?(Twitter::Tweet)
          puts object.text if object.is_a?(Twitter::Tweet) && object.text.include?(brand_1_name) || object.text.include?(brand_2_name)
          if object.text.include?(brand_1_name)
            brand_1_count += 1
          end
          if object.text.include?(brand_2_name)
            brand_2_count += 1
          end

        end
      end
    rescue Exception => e #TODO catch other errors
      puts "catching time out error"
      # next
      battle = Battle.find_by_id(id)
      battle.brand_1_count += brand_1_count
      puts battle.brand_1_count
      battle.brand_2_count += brand_2_count
      battle.save!
      if battle.running == true
        puts "true!"
      end
      retry if battle.running == true
    end
    puts ""
    puts "#{brand_1_name} count: #{brand_1_count}"
    puts "#{brand_2_name} count: #{brand_2_count}"

    # write battle to db
    # battle = Battle.new(:name => "#{coffee} vs. #{football}", :brand_1_hashtag => coffee, :brand_1_count => coffee_count, :brand_2_hashtag => football, :brand_2_count => football_count)
    # battle.save!
    # b = Battle.new(:name => "coffee vs. football", :brand_1_hashtag => "coffee", :brand_1_count => 0, :brand_2_hashtag => "football", :brand_2_count => 0)
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



# client = Twitter::Streaming::Client.new do |config|
#       config.consumer_key        = "AJrghs2Q74I09aAUAoegK3t6G"
#       config.consumer_secret     = "tK2YdY8ACrYSgtUb50z2N8gbYFK2iGar6mYMuLztZQGxaahkDe"
#       config.access_token        = "351152791-gSBD8CXSKOaj3rs2cYNEOkVjBVkzrq7VpF9v9lvG"
#       config.access_token_secret = "61lJYCMJ8DP8NlanYoQR8cevIGInHKpOtblKYLxD5ibeI"
#     end


#     topics = ['coffee','football']
#     brand_1_count = 0
#     brand_2_count = 0
#     brand_1_name = '#' + topics[0]
#     brand_2_name = '#' + topics[1]

#     puts brand_1_name
#     puts brand_2_name


#     since_id = Time.now.to_s

#     begin 
#       Timeout::timeout(20) do #TODO get rid of this & change to "running" or other boolean
#         client.filter(:track => topics.join(',')) do |object|
#           # puts object.text if object.is_a?(Twitter::Tweet)
#           puts object.text if object.is_a?(Twitter::Tweet) && object.text.include?(brand_1_name) || object.text.include?(brand_2_name)
#           if object.text.include?(brand_1_name)
#             brand_1_count += 1
#           end
#           if object.text.include?(brand_2_name)
#             brand_2_count += 1
#           end

#           #Battle.transaction do
#           @@lock.synchronize do
#             battle = Battle.find_by_id(1)
#             battle.brand_1_count += brand_1_count
#             puts battle.brand_1_count
#             battle.brand_2_count += brand_2_count
#             battle.save!
#           end
#           #puts "transaction occurred"
#           #end

#         end
#       end
#     rescue Exception    => e #TODO catch other errors
#       puts "catching time out error"
#       # next
#     end

#     puts ""
#     puts "#{brand_1_name} count: #{brand_1_count}"
#     puts "#{brand_2_name} count: #{brand_2_count}"

    # write battle to db
    # battle = Battle.new(:name => "#{coffee} vs. #{football}", :brand_1_hashtag => coffee, :brand_1_count => coffee_count, :brand_2_hashtag => football, :brand_2_count => football_count)
    # battle.save!
    # b = Battle.new(:name => "coffee vs. football", :brand_1_hashtag => "coffee", :brand_1_count => 0, :brand_2_hashtag => "football", :brand_2_count => 0)
    # proper dismount from the Resque queue











    # client = Twitter::REST::Client.new do |config|
    #   config.consumer_key        = "AJrghs2Q74I09aAUAoegK3t6G"
    #   config.consumer_secret     = "tK2YdY8ACrYSgtUb50z2N8gbYFK2iGar6mYMuLztZQGxaahkDe"
    #   config.access_token        = "351152791-gSBD8CXSKOaj3rs2cYNEOkVjBVkzrq7VpF9v9lvG"
    #   config.access_token_secret = "61lJYCMJ8DP8NlanYoQR8cevIGInHKpOtblKYLxD5ibeI"
    # end


    # topics = ['coffee','football']
    # brand_1_count = 0
    # brand_2_count = 0
    # brand_1_name = '#' + topics[0]
    # brand_2_name = '#' + topics[1]

    # puts brand_1_name
    # puts brand_2_name


    # since_id = Time.now.to_s

    # begin 
    #   client.search("#{brand_1_name}", :result_type => "mixed").take(10).collect do |object|
    #     #puts object.text if object.is_a?(Twitter::Tweet) && object.text.include?(brand_1_name)
    #     if object.text.include?(brand_1_name) && object.is_a?(Twitter::Tweet)
    #       brand_1_count += 1
    #     end

    #     #Battle.transaction do
    #     @@lock.synchronize do
    #       battle = Battle.find_by_id(1)
    #       battle.brand_1_count += brand_1_count
    #       battle.save!
    #     end
    #   end
    # rescue Exception    => e #TODO catch other errors
    #   puts "catching time out error"
    #   # next
    # end

    # begin 
    #   client.search("#{brand_2_name}", :result_type => "mixed").take(10).collect do |object|
    #     #puts object.text if object.is_a?(Twitter::Tweet) && object.text.include?(brand_1_name)
    #     if object.text.include?(brand_2_name) && object.is_a?(Twitter::Tweet)
    #       brand_2_count += 1
    #     end

    #     #Battle.transaction do
    #     @@lock.synchronize do
    #       battle = Battle.find_by_id(1)
    #       battle.brand_2_count += brand_2_count
    #       battle.save!
    #     end
    #   end
    # rescue Exception    => e #TODO catch other errors
    #   puts "catching time out error"
    # end

    # puts ""
    # puts "#{brand_1_name} count: #{brand_1_count}"
    # puts "#{brand_2_name} count: #{brand_2_count}"

    # write battle to db
    # battle = Battle.new(:name => "#{coffee} vs. #{football}", :brand_1_hashtag => coffee, :brand_1_count => coffee_count, :brand_2_hashtag => football, :brand_2_count => football_count)
    # battle.save!
    # b = Battle.new(:name => "coffee vs. football", :brand_1_hashtag => "coffee", :brand_1_count => 0, :brand_2_hashtag => "football", :brand_2_count => 0)
    # proper dismount from the Resque queue