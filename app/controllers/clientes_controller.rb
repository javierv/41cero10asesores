class ClientesController < ApplicationController
  respond_to :js, only: [:destroy]
  respond_to :html

  resource :cliente
  before_filter :new_cliente, only: [:new, :create]
  before_filter :find_cliente, only: [:edit, :update, :destroy]

  def index
    @clientes = Cliente.all
    respond_with @clientes
  end

  def new
  end

  def edit
  end

  def update
    @cliente.update_attributes params[:cliente]
    respond_with @cliente, location: clientes_path
  end

  def create
    @cliente.save
    respond_with @cliente, location: clientes_path
  end

  def destroy
    if @cliente.destroy
      @deshacer = deshacer_borrado_path(@cliente)
      @siguiente = next_cliente if request.xhr?
    end
    respond_with @cliente
  end
end
