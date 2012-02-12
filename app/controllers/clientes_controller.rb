class ClientesController < ApplicationController
  respond_to :js, only: [:destroy]
  respond_to :html

  resource :cliente
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

private
  def cliente
    @cliente ||= find_or_new_cliente
  end

  helper_method :cliente
end
