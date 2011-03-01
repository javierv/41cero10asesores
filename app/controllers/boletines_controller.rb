class BoletinesController < ApplicationController
  respond_to :html

  before_filter :new_boletin, only: [:new, :create]

  def index
    @boletines = Boletin.all
    respond_with @boletines
  end

  def new
  end

  def create
    @boletin.save
    respond_with @boletin, location: boletines_path
  end

private
  def new_boletin
    @boletin = Boletin.new params[:boletin]
  end
end
