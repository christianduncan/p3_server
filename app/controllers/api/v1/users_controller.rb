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
        
        icon_arr = ["https://image.flaticon.com/icons/png/512/22/22732.png",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXj2LhAiir_KVEmUB7r-_w4QwIY1WxreRpNTPhf7p6Nd1Xv76Z",
        "https://ae01.alicdn.com/kf/HTB17eL.QFXXXXa5XFXXq6xXFXXXD/1PCS-Cartoon-Cute-Hello-Kitty-Cat-Icon-Acrylic-Brooch-Badges-Decoration-Pin-Buttons-Backpack-Clothes-Accessories.jpg"]
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