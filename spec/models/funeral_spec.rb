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
        it '空だとNG' do
          funeral.start_time = ''
          expect(funeral).to be_invalid
        end
      end

      describe 'number_of_people' do
        it '空だとNG' do
          funeral.number_of_people = ''
          expect(funeral).to be_invalid
        end

        it '101以上だとNG' do
          funeral.number_of_people = 101
          expect(funeral).to be_invalid
        end
      end

      describe 'family_name' do
        it '空だとNG' do
          funeral.family_name = ''
          expect(funeral).to be_invalid
        end

        it '文字数が51文字以上だとNG' do
          funeral.family_name = 'ア' * 51
          expect(funeral).to be_invalid
        end
      end
    end
  end
end
