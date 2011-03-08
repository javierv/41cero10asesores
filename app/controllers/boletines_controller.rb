class BoletinesController < ApplicationController
  respond_to :html

  resource :boletin
  before_filter :new_boletin, only: [:new, :create]
  before_filter :find_boletin, only: [:edit, :update, :enviar, :email]

  def index
    @boletines = Boletin.all
    respond_with @boletines
  end

  def new
  end

  def edit
  end

  def update
    @boletin.update_attributes params[:boletin]
    respond_with @boletin, location: boletines_path
  end

  def create
    @boletin.save
    respond_with @boletin, location: boletines_path
  end

  def enviar
    @boletin.clientes = Cliente.all.map(&:mailto)
    respond_with @boletin
  end

  def email
    @boletin.enviar params[:boletin]
    respond_with @boletin, location: boletines_path
  end
end
