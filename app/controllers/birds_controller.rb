class BirdsController < ApplicationController

    # refecfor exception 
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # GET /birds
    def index 
        birds = Bird.all 
        render json: birds, except: [:created_at, :updated_at]
    end

    # GET /birds/:id
    def show 
        bird = find_bird
        render json:bird 
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
        bird = find_bird
        bird.update(bird_filter)
        render json: bird
    end

    def destroy 
        # search the bird with the id 
        bird = find_bird
        bird.destroy 
        head :no_content
    end

    # is private method will filter what came from user
    # all below are private
    private 
    def bird_filter 
        # give permmission to the param
        params.permit(:name, :species)
    end

    # handling find method
    def find_bird
        Bird.find(params[:id])
    end

    # handling 404 response 
    def render_not_found_response 
        render json: {error: "The bird you find is not in the database!"}, status: :not_found
    end
end
