class Admin::ClientsController < Admin::ApplicationController

    def index
      @clients = Client.all
    end

    def new
      @client = Client.new
    end

    def create
      @client = Client.new(client_params)
      if @client.save
        redirect_to admin_clients_path, notice: "#{@client.name}を新しく登録しました"
      else
        flash.now[:alert] = "登録に失敗しました"
        render :new
      end
    end

    def edit
      @client = Client.find(params[:id])
    end

    def update
      @client = Client.find(params[:id])
      if @client.update(client_params)
        redirect_to admin_clients_path, notice: "修正しました"
      else
        flash.now[:alert] = "登録に失敗しました"
        render :edit
      end
    end

    def destroy
      client = Client.find(params[:id])
      if client.destroy
        redirect_to admin_clients_path, notice: "#{client.name}を削除しました"
      else
        flash.now[:alert] = "削除できませんでした"
        render :edit
      end
    end

    private

      def client_params
        params
          .require(:client)
          .permit(:name, :dispatching_fee_per_hour)
      end

  end
