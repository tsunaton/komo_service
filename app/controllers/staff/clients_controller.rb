class Staff::ClientsController < Staff::ApplicationController

    def index
      @clients = Client.all
    end

  end
