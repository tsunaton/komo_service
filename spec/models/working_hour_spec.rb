require 'rails_helper'

RSpec.describe WorkingHour, type: :model do

  before do
    @working_hour = build(:working_hour)
  end

  describe 'バリデーション' do


    context "通る" do

      # it 'OK' do
      #   expect(@working_hour).to be_valid
      # end

    end


    context "通らない" do

      describe "start_time" do

        it '空だとNG' do
          @working_hour.start_time = ''
          expect(@working_hour).to be_invalid
        end

      end
    end
  end
end
