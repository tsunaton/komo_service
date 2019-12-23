class Admin::HomesController < Admin::ApplicationController
  include DocumentsHelper

  # def home
    #今月の利益
    # works = get_works_in_month(Time.now)
    # @monthly_gains = calculate_sales(works) - calculate_labor_costs(works)
    #
    # funerals_after_today = Funeral.where('start_time >= ?', Date.today)
    # working_hours_need_transportation_fee = WorkingHour.where(transportation_fee: nil).where(status: "done")
    # funerals_need_transportation_fee = working_hours_need_transportation_fee.inject(Array(nil)){|funerals, w| funerals << w.funeral}
    #
    # @funerals = funerals_after_today + funerals_need_transportation_fee
    # @funerals.uniq!
  # end
    def home
      html = File.read("https://komo-service-staging.herokuapp.com/admin/payslips")
      kit = PDFKit.new(html, :page_size => 'Letter')
      kit.stylesheets << "/assets/stylesheets/styles.css"
      kit.to_file("#{Rails.root}/public/example.pdf")
      send_data kit.to_pdf, filename: 'example.pdf', type: 'application/pdf'
    end
  end
