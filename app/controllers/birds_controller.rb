class BirdsController < ApplicationController

    # GET /birds
    def index 
        render json:Bird.all 
    end

    # GET /birds/:id
    def show 
        bird = Bird.find_by(id: params[:id])
        if bird 
            render json:bird, status: :ok
        else 
            render json: {error: "Bird not found!"}, status: :not_found
        end
    end 

    # POST /birds
    def create 
        # use the private method to filter 
        bird = Bird.create(bird_filter)
        render json: bird, status: :created
    end

    # PATCH or PUT /birds/:id
    def update 
        # search the bird with the id 
        bird = Bird.find_by(id: params[:id])
        if bird 
            bird.update(bird_filter)
            render json: bird, status: :accepted 
        else 
            render json: {error: "The bird you find is not in the database!"}, status: :not_found
        end
    end

    def destroy 
        # search the bird with the id 
        bird = Bird.find_by(id: params[:id])
        if bird 
            bird.destroy 
            head :no_content
            # render json: bird, status: :ok 
        else 
            render json: {error: "The bird you find is not in the database!"}, status: :not_found
        end
    end

    # is private method will filter what came from user
    # all below are private
    private 
    def bird_filter 
        # give permmission to the param
        params.permit(:name, :species)
    end
end
