require 'rails_helper'

RSpec.describe FuneralHall, type: :model do
  before do
    @funeral_hall = build(:funeral_hall)
  end

  describe 'バリデーション' do
    context '通る' do
      it 'OK' do
        expect(@funeral_hall).to be_valid
      end
    end

    context '通らない' do
      describe 'name' do
        it '空だとNG' do
          @funeral_hall.name = ''
          expect(@funeral_hall).to be_invalid
        end

        it 'カブるとNG' do
          @funeral_hall.name = 'SAME_NAME'
          @funeral_hall.save
          dup = FuneralHall.new(name: 'SAME_NAME')
          expect(dup).to be_invalid
        end

        it '文字数が51文字以上だとNG' do
          @funeral_hall.name = 'ア' * 51
          expect(@funeral_hall).to be_invalid
        end
      end

      describe 'address' do
        it '文字数が51文字以上だとNG' do
          @funeral_hall.address = 'ア' * 51
          expect(@funeral_hall).to be_invalid
        end
      end

      describe 'nearest_station' do
        it '文字数が51文字以上だとNG' do
          @funeral_hall.address = 'ア' * 51
          expect(@funeral_hall).to be_invalid
        end
      end
    end
  end
end
