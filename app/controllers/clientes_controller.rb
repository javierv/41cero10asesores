class ClientesController < ApplicationController
  respond_to :js, only: [:destroy]
  respond_to :html

  resource :cliente
  before_filter :new_cliente, only: [:new, :create]
  before_filter :find_cliente, only: [:edit, :update, :destroy]
  before_filter :destroy_cliente, only: :destroy

  def index
    @clientes = ClienteDecorator.all
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
    respond_with @cliente
  end
end
