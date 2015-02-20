require 'mechanize'
require 'yaml'

shops = YAML.load_file('data/shops.yml')
times = YAML.load_file('data/times.yml')

url = 'https://www.ginzarenoir.jp/grms/pub/pc/schedule.php'
shop_key = 'c_type'
date_key = 'date'

vacant = []
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
      vacant = true
			for i in 1..tds.size-1
				if tds[i][:title].nil?
          # 予約済みもしくは利用不可
					# p tds[i][:bgcolor]
				else
          # 予約可能
					p tds[i][:title]

          # 暫定対応
          # 11:00 - 19:00 が空いている部屋、日時のみ表示
				end
			end
			break
		end
	end
end
