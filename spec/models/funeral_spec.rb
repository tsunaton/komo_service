require 'rails_helper'

RSpec.describe Funeral, type: :model do
  let(:funeral) { build(:funeral) }


  describe 'バリデーション' do
    context '通る' do
      it 'OK' do
        expect(funeral).to be_valid
      end
    end

    context '通らない' do
      describe 'start_time' do
        it 'start_timeが空だとNG' do
          funeral.start_time = ''
          expect(funeral).to be_invalid
        end
      end

      describe 'number_of_people' do
        it 'number_of_peopleが空だとNG' do
          funeral.number_of_people = ''
          expect(funeral).to be_invalid
        end

        it 'number_of_peopleが101以上だとNG' do
          funeral.number_of_people = 101
          expect(funeral).to be_invalid
        end
      end
    end
  end
end
