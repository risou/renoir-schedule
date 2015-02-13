require 'mechanize'
require 'yaml'

shops = YAML.load_file('data/shops.yml')
times = YAML.load_file('data/times.yml')

url = 'https://www.ginzarenoir.jp/grms/pub/pc/schedule.php'
shop_key = 'c_type'
date_key = 'date'

agent = Mechanize.new

shops["shops"].each do |key, value|

	today = Date::today

	# for num in 0..0
	for num in 0..59 do
    if ![0, 6].include?((today + num).wday)
      next
    end
		day = (today + num).to_s

		sleep(1)
		page = agent.get(url + '?' + shop_key + '=' + key.to_s + '&' + date_key + '=' + day)
		rooms = page.search('tbody.scrollContent').xpath('tr')
		rooms.pop
		rooms.each do |room|
			tds = room.xpath('td')
			room_info = tds[0].inner_text
      usable = []
			for i in 1..tds.size-1 do
				if tds[i][:title].nil?
				else
					usable.push i
				end
			end
      if usable & [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22] == [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22]
        p room_info + ' ' + day
      end
		end
	end
end
