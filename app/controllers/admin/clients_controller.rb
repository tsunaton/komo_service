class Admin::ClientsController < Admin::ApplicationController

    def index
      @clients = Client.all
    end

    def new
      @client = Client.new
    end

    def create
      client = Client.new(client_params)
      if client.save
        redirect_to action: 'index'
      else
        render :back
      end
    end

    def edit
      @client = Client.find(params[:id])
    end

    def update
      client = Client.find(params[:id])
      if client.update(client_params)
        redirect_to admin_clients_path
      else
        render :edit
      end
    end

    def destroy
    end

    private

      def client_params
        params
          .require(:client)
          .permit(:name, :dispatching_fee_per_hour)
      end

  end
