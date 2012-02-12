class BoletinesController < ApplicationController
  respond_to :js, only: [:destroy]
  respond_to :html

  public_actions :show
  resource :boletin

  expose(:boletin) { find_or_new_boletin }

  before_filter :destroy_boletin, only: :destroy

  def index
    @boletines = BoletinDecorator.all
    respond_with @boletines
  end

  def show
    send_file boletin.archivo.file, filename: boletin.archivo.name, type: :pdf
  end

  def new
  end

  def edit
  end

  def update
    boletin.update_attributes params[:boletin]
    respond_with boletin, location: boletines_path
  end

  def create
    boletin.save
    respond_with boletin, location: boletines_path
  end

  def destroy
    respond_with boletin
  end

  def enviar
    boletin.clientes = Cliente.all.map(&:mailto)
    respond_with boletin
  end

  def email
    boletin.enviar params[:boletin]
    respond_with boletin, location: boletines_path
  end
end
