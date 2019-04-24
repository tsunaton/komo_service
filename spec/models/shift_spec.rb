require "rails_helper"

RSpec.describe Shift, type: :model do
  before do
    @shift = build(:shift)
  end

  describe "バリデーション" do
    context "通る" do
      # it 'OK' do
      #   expect(@shift).to be_valid
      # end
    end

    context "通らない" do
      describe "scheduled_from" do
        it "空だとNG" do
          @shift.scheduled_from = ""
          expect(@shift).to be_invalid
        end
      end

      describe "scheduled_to" do
        it "空だとNG" do
          @shift.scheduled_to = ""
          expect(@shift).to be_invalid
        end
      end
    end
  end
end
