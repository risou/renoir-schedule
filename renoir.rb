require 'mechanize'
require 'yaml'

shops = YAML.load_file('data/shops.yml')
times = YAML.load_file('data/times.yml')

url = 'https://www.ginzarenoir.jp/grms/pub/pc/schedule.php'
shop_key = 'c_type'
date_key = 'date'

agent = Mechanize.new

shops["shops"].each do |key, value|
	p key
	p value

	today = Date::today
	for num in 0..0
	# for num in 0..59
		day = (today + num).to_s

		sleep(1)
		page = agent.get(url + '?' + shop_key + '=' + key.to_s + '&' + date_key + '=' + day)
		rooms = page.search('tbody.scrollContent').xpath('tr')
		rooms.pop
		rooms.each do |room|
			tds = room.xpath('td')
			room_info = tds[0].inner_text
			for i in 1..tds.size-1
				if tds[i][:title].nil?
					p tds[i][:bgcolor]
				else
					p tds[i][:title]
				end
			end
			break
		end
	end
end
