class ClientesController < ApplicationController
  respond_to :js, only: [:destroy]
  respond_to :html

  resource :cliente

  expose(:cliente) { find_or_new_cliente }
  expose(:clientes) { ClienteDecorator.all }

  before_filter :destroy_cliente, only: :destroy

  def index
    respond_with clientes
  end

  def new
  end

  def edit
  end

  def update
    cliente.update_attributes params[:cliente]
    respond_with cliente, location: clientes_path
  end

  def create
    cliente.save
    respond_with cliente, location: clientes_path
  end

  def destroy
    respond_with cliente
  end
end
