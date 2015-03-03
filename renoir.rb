require 'mechanize'
require 'yaml'

shops = YAML.load_file('data/shops.yml')
times = YAML.load_file('data/times.yml')

url = 'https://www.ginzarenoir.jp/grms/pub/pc/schedule.php'
shop_key = 'c_type'
date_key = 'date'

vacant = {}
agent = Mechanize.new

today = Date::today
# for num in 0..0
for num in 0..59
  day = today + num
  day_s = (today + num).to_s
  if [0, 6].include?((today + num).wday)

    usable = {}
    shops["shops"].each do |key, value|

      sleep(1)
      page = agent.get(url + '?' + shop_key + '=' + key.to_s + '&' + date_key + '=' + day_s)
      rooms = page.search('tbody.scrollContent').xpath('tr')
      rooms.pop
      rooms.each do |room|
        tds = room.xpath('td')
        room_info = tds[0].inner_text
        usable_times = []
        for i in 1..tds.size-1
          if tds[i][:title].nil?
            # 予約済みもしくは利用不可
            # p tds[i][:bgcolor]
          else
            # 予約可能
            # p tds[i][:title]
            usable_times.push(i)

            # 暫定対応
            # 11:00 - 19:00 が空いている部屋、日時のみ表示
          end
        end
        usable[room_info] = usable_times
      end

    end

    vacant[day] = usable
  end
end

vacant.each do |day, rooms|
  p day.to_s
  rooms.each do |room, time|
    if [*(7..22)] & time == [*(7..22)]
      p room
    end
  end
end