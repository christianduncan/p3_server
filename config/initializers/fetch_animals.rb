


#get access token from petfinder servers
t_res = Unirest.post "https://api.petfinder.com/v2/oauth2/token",
        parameters: {"grant_type" => "client_credentials",
                      "client_id" => "#{ENV["PETFINDER_APIKEY"]}",
                      "client_secret" => "#{ENV["PETFINDER_SECRET"]}"
                    }


ENV["PETFINDER_TOKEN"] = t_res.body['access_token']

response = Unirest.get "https://api.petfinder.com/v2/animals?type=animal&breed=corgi&gender=male&limit=100",
              headers: {Authorization: "Bearer #{ENV["PETFINDER_TOKEN"]}"}

    
animal_list = response.body['animals']

if animal_list == nil
  puts "animal_list didn't populate"
else
  animal_list.each do |animal|
    existing_animal = Animal.find_by source_id: animal['id']
    if existing_animal == nil
      if animal['photos'] == []
        image_url = ""
      else
        image_url = animal['photos'][0]['small']
      end

      new_animal = Animal.create(
        name: animal['name'],
        source_id: animal['id'],
        url: animal['url'],
        imageURL: image_url,
        description: animal['description']
      )
    end
  end
end