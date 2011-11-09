class BoletinesController < ApplicationController
  respond_to :js, only: [:destroy]
  respond_to :html

  public_actions :show
  resource :boletin
  before_filter :new_boletin, only: [:new, :create]
  before_filter :find_boletin, only: [:show, :edit, :update, :destroy, :enviar, :email]

  def index
    @boletines = Boletin.all
    respond_with @boletines
  end

  def show
    send_file @boletin.archivo.file, filename: @boletin.archivo.name, type: :pdf
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

  def destroy
    if @boletin.destroy
      @deshacer = deshacer_borrado_path(@boletin)
      @siguiente = next_boletin if request.xhr?
    end
    respond_with @boletin
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