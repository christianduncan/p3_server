#get access token from petfinder servers
t_res = Unirest.post "https://api.petfinder.com/v2/oauth2/token",
        parameters: {"grant_type" => "client_credentials",
                      "client_id" => "abwlgnjXXuHyt0YRk52BESSSez0DkWZLYOrpOYjv8i347zjDvg",
                      "client_secret" => "9nqLwZnxd3GbSIgFpjPBmlsQdeqyjS1vrn0arqfx"
                    }

ENV["PETFINDER_TOKEN"] = t_res.body['access_token']
if ENV["PETFINDER_TOKEN"] == nil 
  puts 'no'
end

response = Unirest.get "https://api.petfinder.com/v2/organizations?location=10014&distance=250&limit=100",
              headers: {Authorization: "Bearer #{ENV["PETFINDER_TOKEN"]}"}

shelter_list = response.body['organizations']

if shelter_list == nil
  puts "shelter_list didn't populate"
else
  shelter_list.each do |shelter|
    existing_shelter = Shelter.find_by source_id: shelter['id']
    if existing_shelter == nil
      new_shelter = Shelter.find_or_create_by(
        name: shelter['name'],
        source_id: shelter['id'],
        url: shelter['url'],
        state: shelter['address']['state'],
        city: shelter['address']['city'],
        address: shelter['address']['address1']
      )
    end
  end
end
