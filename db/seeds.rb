require 'json'
require 'rest_client'

Soulmate.redis = 'redis://:Aa123456!@pub-redis-10628.us-east-1-3.3.ec2.garantiadata.com:10628/0'
time1 = Time.new
puts "Started - Current Time : " + time1.inspect
arr = ('a'..'a').to_a
index = 1
finished = false
url = ''
begin
	arr.each do | char |
		while finished == false do
      url = "https://www.fiverr.com/users/search_as_json/auto?username=#{char}&page=#{index}"
      response = RestClient.get url
      data = JSON.parse(response.to_str)
			data['users'].each do | user |
				Person.create :name => user['username'], :user_id => user['id'], :rating_count => user['rating']
			end
			total_results = data['total_results']
      break if index == 10
			if (total_results - (50 * index)) > 0
				index = index + 1
			else
				finished = true
      end
      puts "finished with page #{index} of char #{char}"
    end
    puts "finished with the letter #{char}"
		index = 1
		finished = false
	end
rescue Exception => e
  puts "Finished - there was an error index=#{index}, url=#{url}"
  puts "error message: #{e.message}"
  puts "error backtrace: #{e.backtrace}"
end

time1 = Time.new
puts 'Finished - Current Time : ' + time1.inspect