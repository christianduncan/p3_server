


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

response = Unirest.get "https://api.petfinder.com/v2/animals?page=1&limit=100",
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
        image_url = animal['photos'][0]['medium'] 
        email = animal['contact']['email']
      end

      new_animal = Animal.create(
        name: animal['name'],
        source_id: animal['id'],
        url: animal['url'],
        imageURL: image_url,
        description: animal['description'],
        email: email,
        phone: animal['contact']['phone'],
        address1: animal['contact']['address']['address1'],
        city: animal['contact']['address']['city'],
        state: animal['contact']['address']['state']
      )
    end
  end
end