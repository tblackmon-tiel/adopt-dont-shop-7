class ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
    if params[:pet_search]
      @searched_pets = Pet.search(params[:pet_search])
    end
  end

  def new

  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Please fill in all fields."
      render :new
    end
  end

  def update
    application = Application.find(params[:id])
    pets = application.pets
    application.update(
      adoption_description: params[:adoption_description],
      status: "Pending"
    )
    application.save
    application.pets = pets

    redirect_to "/applications/#{application.id}"
  end

  def add_pet
    application = Application.find(params[:id])
    application.add_pet(params[:pet_id])

    redirect_to "/applications/#{application.id}"
  end

  private
    def application_params
      full_addr = "#{params[:addr]}, #{params[:city]}, #{params[:state]}, #{params[:zip]}"
      params.permit(:name, :description).merge(address: full_addr, status: "In Progress")
    end
end