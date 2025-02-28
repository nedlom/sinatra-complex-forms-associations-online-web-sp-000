class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params["pet_name"])
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
    else
      @owner = Owner.find_by_id(params["owner_id"])
    end
    @pet.owner = @owner
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by_name(params["owner"]["name"])
    @pet.update(name: params["pet_name"], owner: @owner)
        if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end