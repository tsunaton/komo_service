require 'rails_helper'

RSpec.describe Client, type: :model do
  before do
    @client = build(:client)
  end

  describe 'バリデーション' do
    context '通る' do
      it 'OK' do
        expect(@client).to be_valid
      end
    end

    context '通らない' do
      describe 'name' do
        it '空だとNG' do
          @client.name = ''
          expect(@client).to be_invalid
        end

        it 'カブるとNG' do
          @client.name = 'SAME_NAME'
          @client.save
          dup = Client.new(name: 'SAME_NAME', address: 'not_same', dispatching_fee_per_hour: 9999)
          expect(dup).to be_invalid
        end

        it '文字数が51文字以上だとNG' do
          @client.name = 'ア' * 51
          expect(@client).to be_invalid
        end
      end

      describe 'address' do
        it 'カブるとNG' do
          @client.address = 'SAME_ADDRESS'
          @client.save
          dup = Client.new(name: 'not_same', address: 'SAME_ADDRESS', dispatching_fee_per_hour: 9999)
          expect(dup).to be_invalid
        end

        it '文字数が51文字以上だとNG' do
          @client.address = 'ア' * 51
          expect(@client).to be_invalid
        end
      end

      describe 'dispatching_fee_per_hour' do
        it '10000未満だとNG' do
          @client.dispatching_fee_per_hour = 10000
          expect(@client).to be_invalid
        end
      end
    end
  end
end
