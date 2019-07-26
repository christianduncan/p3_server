class Api::V1::UsersController < ApplicationController
    
    def index
        users = User.all 

        render json: users 
    end 
    
    
    def show
		user = User.find(params[:id])

		render json: user
	end

    def create
        
        icon_arr = ["https://github.com/christianduncan/p3_server/blob/master/app/assets/images/eagle.png?raw=true",
        "https://github.com/christianduncan/p3_server/blob/master/app/assets/images/elephant.png?raw=true",
		"https://github.com/christianduncan/p3_server/blob/master/app/assets/images/gator.png?raw=true",
		"https://github.com/christianduncan/p3_server/blob/master/app/assets/images/giraffe.png?raw=true",
		"https://github.com/christianduncan/p3_server/blob/master/app/assets/images/gorilla.png?raw=true",
		"https://github.com/christianduncan/p3_server/blob/master/app/assets/images/lion.png?raw=true",
		"https://github.com/christianduncan/p3_server/blob/master/app/assets/images/monkey.png?raw=true"
	]
		user = User.new(
			name: params[:name],
			username: params[:username],
			password: params[:password],
		
			
			avatar_url: icon_arr.sample
		)

		if user.save

			token = encode_token(user.id)

			render json: {user: UserSerializer.new(user), token: token}
		else
			render json: {errors: user.errors.full_messages}
		end
	end
	
	def favorite
    	@animal = Animal.find(params[:animal_id])
    	@user = User.find(params[:id])

    	if @user.animals.include? @animal
      	@user.animals.delete(@animal)

    	else
      		@user.animals << @animal
      		@user.save
    	end

    	render json: @user
  	end




	
end 