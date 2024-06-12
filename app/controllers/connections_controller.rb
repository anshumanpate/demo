class ConnectionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
    before_action :authenticate_user!
    before_action :set_connection, only: [:show, :accept, :cancel, :block]
    before_action :authorize_user!, only: [:accept, :cancel, :block]
  
    def index
      @connections = Connection.where(requestee: current_user, status: 'pending')
    end
  
    def show
    end
  
    def new
      @connection = Connection.new
    end
  
    def create
      @connection = Connection.new(connection_params)
      @connection.requester = current_user
      @connection.status = 'pending'
  
      if @connection.save
        redirect_to connections_url, notice: 'Connection request was successfully created.'
      else
        render :new
      end
    end
  
    def accept
      if @connection.requestee == current_user && @connection.update(status: 'accepted')
        redirect_to connections_path, notice: 'Connection was successfully accepted.'
      else
        render :show, alert: 'Unable to accept connection.'
      end
    end
  
    def cancel
      if @connection.requestee == current_user && @connection.update(status: 'cancelled')
        redirect_to connection_path, notice: 'Connection was successfully cancelled.'
      else
        render :show
      end
    end
  
    def block
      if @connection.requestee == current_user && @connection.update(status: 'blocked')
        redirect_to @connection, notice: 'Connection was successfully blocked.'
      else
        render :show
      end
    end
  
    private
  
    def set_connection
      @connection = Connection.find(params[:id])
    end
  
    def connection_params
      params.require(:connection).permit(:requestee_id)
    end
  
    def authorize_user!
      unless @connection.requester == current_user || @connection.requestee == current_user
        redirect_to connections_path, alert: 'Unauthorized'
      end
    end
  end
  