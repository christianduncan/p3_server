


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
no_img = "https://cdn.dribbble.com/users/49396/screenshots/3525019/pets-icon-dutch-government-dribbble.png"

if animal_list == nil
  puts "animal_list didn't populate"
else
  animal_list.each do |animal|
    existing_animal = Animal.find_by source_id: animal['id']
    if existing_animal == nil
      if animal['photos'] == []
        image_url = no_img 
        
      else
        image_url = animal['photos'][0]['medium'] 
      
        
      end

      new_animal = Animal.create(
        name: animal['name'],
        source_id: animal['id'],
        url: animal['url'],
        imageURL: image_url,
        description: animal['description'],
        email: animal['contact']['email'],
        phone: animal['contact']['phone'],
        address1: animal['contact']['address']['address1'],
        city: animal['contact']['address']['city'],
        state: animal['contact']['address']['state'],
        gender: animal['gender'],
        size: animal['size'],
        age: animal['age'],
        breed: animal['breeds']['primary']
      )
      
    end
  end
end
