class Admin::FuneralsController < Admin::ApplicationController

  def index
    @funerals = Funeral.all
  end

  def new
    start_time = Time.zone.parse(params[:start_date] + " " + params[:start_time])
    quickest_end_time = start_time + 4.hours

    @shift = Shift.new
    @shifts = @shift.matches(start_time, quickest_end_time)

    @users = [User.find_by(user_type: "admin")]
    @shifts.each do |shift|
      user = User.find(shift.user_id)
      @users.append(user)
    end

    @funeral = Funeral.new(start_time: start_time, number_of_people: params[:number_of_people])
    @hall_id = params[:funeral_hall]
    @hall_name = FuneralHall.find(@hall_id).name
    @clients = Client.all
  end

  def create
    @funeral = Funeral.new(funeral_params)

    if funeral_params[:working_hours_attributes]
      @users = @funeral.working_hours.map{ |w| User.where(id: w.user_id) }
      if @funeral.save!
        @users.each do |u|
          case u[0].user_type
          when "admin"
            render :new unless @funeral.working_hours[0].update(start_time: @funeral.start_time, status: "accepted")
          when "staff"
            render :new unless WorkAcceptanceMailer.send_mail(u[0], @funeral, @funeral.working_hours[0]).deliver_later
          end
        end
        redirect_to admin_home_path, notice: "#{@users[0].map { |u| u.family_name + u.first_name + "さん" }}に、お仕事依頼をしました"
      else
        render :new
      end
    else
      render :new unless @funeral.save
      redirect_to admin_home_path
    end
  end

  def show
    @funeral = Funeral.find(params[:id])
    @users = @funeral.users.map { |user| user.family_name }
  end

  def update
    funeral = Funeral.find(params[:id])
    if funeral.update(funeral_params)
      redirect_to admin_funerals_path
    else
      render :edit
    end
  end

  def search_page
    t = Date.today
    @days = (t..(t + 7)).to_a

    @halls = FuneralHall.all

    if Funeral.all.count > 0
      @last_funeral = Funeral.find(Funeral.all.ids.max)
      @last_day = @last_funeral.start_time.day
      @last_hall_id = @last_funeral.funeral_hall_id
    else
      @last_day = Time.current.day
      @last_hall_id = FuneralHall.first.id
    end
  end

  def destroy
  end

  private

    def funeral_params
    params.require(:funeral)
          .permit(:start_time,
                  :funeral_hall_id,
                  :client_id,
                  :family_name,
                  :number_of_people,
                  working_hours_attributes:[:user_id])
    end

end
