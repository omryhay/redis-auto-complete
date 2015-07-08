require 'json'
require 'rest_client'

time1 = Time.new
puts "Started - Current Time : " + time1.inspect
arr = ('a'..'z').to_a
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
			if (total_results - (50 * index)) > 0
				index = index + 1
			else
				finished = true
			end
		end
		index = 1
		finished = false
	end
rescue
	puts "Finished - there was an error index=#{index}, url=#{url}"
end
Person.find_each do |person|
  person.load_into_soulmate
end

time1 = Time.new
puts 'Finished - Current Time : ' + time1.inspect