class Staff::WorkingHoursController < Staff::ApplicationController
  def new
  end

  def create
  end

  def edit
    # common
    @working_hour = WorkingHour.find(params[:id])
    @funeral = @working_hour.funeral
    @client = @funeral.client
    @funeral_halls = FuneralHall.all.inject(Array(nil)){ |funeral_halls,f| funeral_halls << f.name}

    #for _forgotten_end_report partial
    @admin_user = User.find_by(user_type: 'admin')

    # for modify_working_hour partial
    @funeral_hall = @funeral.funeral_hall
    @end_time = params[:end_time]

    # 現在時刻から、15分未満を切り捨てる
    @rounded_down_time = Time.at((Time.now.to_f.round / 15.minutes) * 15.minutes)
  end

  def update
    working_hour = WorkingHour.find(params[:id])
    action = proc {|cond|
      if cond
        redirect_to staff_home_path
      else
        render :edit
      end
    }

    case working_hour_params[:commit]
    when "受ける"
      action.(working_hour.update(start_time: working_hour.funeral.start_time, status: "accepted") && NoticeAcceptedMailer.send_mail(@current_user, working_hour).deliver_later)
    when "辞退する"
      action.(working_hour.update(status: "rejected"))
    end

    if @current_user.user_type == "admin"
      if working_hour.update(working_hour_params.merge(status: "done")) && working_hour.funeral.update(funeral_params)
        redirect_to admin_payslips_path,notice: "修正されました"
      else
        render :modify_working_hour, alert: "修正に失敗しました"
      end
    else
      if working_hour.update(end_time: working_hour_params[:end_time], status: "done")
        redirect_to admin_payslips_path, notice: "終了報告をしました"
      else
        render :edit, alert: "終了報告に失敗しました"
      end
    end
  end

  def destroy
  end

  def modification_report
    @working_hour = WorkingHour.find(params[:id])
    @t = modification_report_params[:end_time]
  end

  def send_modification_report
    @working_hour = WorkingHour.find(modification_report_params[:working_hour_id])
    funeral = @working_hour.funeral
    content = modification_report_params[:content]
    end_time = Time.zone.parse( modification_report_params[:end_time] )
    if @working_hour.update(end_time: end_time)
      if ModificationReportMailer.send_mail(@current_user, @working_hour,
                                            funeral, end_time, content).deliver_later
        redirect_to staff_home_path, notice: "修正依頼を送信しました"
      else
        render :back, alert: "送信に失敗しました"
      end
    else
      render :back, alert: "送信に失敗しました"
    end
  end

  def form_transportation_fee
    @working_hour = WorkingHour.new
    funerals = Funeral.where(start_time: Funeral.find(form_transportation_fee_params[:funeral_id]).start_time)
    works = funerals.inject(Array(nil)){|works, f| works << f.working_hours }
    @works = works[0  ].where(transportation_fee: nil)
    if @works.empty?
      redirect_to admin_home_path, notice: "保存が完了しました"
    end
  end

  def update_transportation_fee
    work = WorkingHour.find(update_transportation_fee_params[:working_hour_id])
    if work.update(transportation_fee: update_transportation_fee_params[:transportation_fee])
      redirect_to staff_form_transportation_fee_path(funeral_id: update_transportation_fee_params[:funeral_id]), notice: '交通費を保存しました'
    end
  end

  private

    def working_hour_params
      if params[:working_hour]
        params
          .require(:working_hour)
          .permit(WorkingHour::WORKINGHOUR_ATTRIBUTES)
      else
        params.permit(:commit)
      end
    end

    def funeral_params
      params
        .require(:working_hour)
        .permit(:funeral_hall_id, :client_id, :family_name)
    end

    def modification_report_params
      params
        .permit(:content, :working_hour_id, :end_time)
    end

    def form_transportation_fee_params
      params
        .permit(:funeral_id)
    end

    def update_transportation_fee_params
      params
        .require(:working_hour)
        .permit(:working_hour_id, :transportation_fee, :funeral_id)
    end

    def work_started?(working_hour)
      if working_hour.status == "accepted" && start_time = working_hour.start_time
        Time.now >= start_time
      end
    end

end
