namespace :scrap do
  task universites_list: :environment do

    puts "*********************started collecting data************************"

    # base url
    base_url = 'http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities/data'

    #initalize universites array
    universites_array = []

    page_count = 1

    while true

      puts "page count" + page_count.to_s

      # parameter need to be pass
      params = {'format': 'json'}
      params = {'_page': page_count.to_i, 'format': 'json'} if page_count != 1

      # hit api to get the data
      begin
        resource = RestClient::Resource.new(base_url,:timeout => 100, :open_timeout => 5)
        response = resource.get params: params , :content_type => 'application/json'
      rescue
        response = nil
      end

      break if response.blank?

      response = JSON.parse(response.try(:body))
      # check vaild data
      # get the list of instituions
      list_of_instituions =  response['data']['results']['data']['items']
      list_of_instituions.each do |list_of_instituion|
        instituion_details = {}
        instituion_details['name'] = list_of_instituion['institution']['displayName'].to_s
        instituion_details['rank'] = list_of_instituion['ranking']['displayRank'].to_s
        instituion_details['tuition_fees'] = list_of_instituion['searchData']['tuition']['displayValue']
        instituion_details['acceptance_rate'] = list_of_instituion['searchData']['acceptance-rate']['displayValue'].to_s
        universites_array << instituion_details
      end

      page_count += 1
    end

    puts "*********************writing to json************************"

    puts universites_array
    universites_array << {'total_count': universites_array.count}
    File.open("public/universites_list.json","w") do |f|
      f.write(universites_array.to_json)
    end

    puts "**********#{universites_array.count}***********process completed json universites_list.json file************************"
  end
end
