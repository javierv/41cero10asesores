class BoletinesController < ApplicationController
  respond_to :html

  def index
    @boletines = Boletin.all
    @boletin = Boletin.new
    respond_with @boletines
  end

  def create
    @boletin = Boletin.new params[:boletin]
    @boletin.save
    respond_with @boletin, location: boletines_path
  end
end
