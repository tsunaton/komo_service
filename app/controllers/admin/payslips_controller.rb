class Admin::PayslipsController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @month = Date.today

    case payslip_params[:transition]
    when "next_month"
      @month = Time.zone.parse(payslip_params[:month] + " 00:00:00").next_month
    when "last_month"
      @month = Time.zone.parse(payslip_params[:month] + " 00:00:00").last_month
    end
    @working_hours = WorkingHour.month(@month).where(user_id: @user.id).where(status: ["done"])
    @working_hour = WorkingHour.new
    @working_hour_ids = Array.new

    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        # 詳細画面のHTMLを取得
        html = render_to_string template: "admin/payslips/show"

        # PDFKitを作成
        pdf = PDFKit.new(html, encoding: "UTF-8")

        # スタイルシートの設定
        pdf.stylesheets << "#{Rails.root}/app/assets/stylesheets/pdf.css"

        # 画面にPDFを表示する
        # to_pdfメソッドでPDFファイルに変換する
        # 他には、to_fileメソッドでPDFファイルを作成できる
        # disposition: "inline" によりPDFはダウンロードではなく画面に表示される
        send_data pdf.to_pdf,
          filename:    "#{@user.family_name}.pdf",
          type:        "application/pdf",
          disposition: "attachment"
      end
    end
  end

  def payslip_params
    params
      .permit(:month, :transition)
  end
end
