class ClientesController < ApplicationController
  respond_to :html

  resource :cliente
  before_filter :new_cliente, only: [:new, :create]
  before_filter :find_cliente, only: [:edit, :update]

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
end
