require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build(:client) }

  describe 'バリデーション' do
    context '通る' do
      it 'OK' do
        expect(client).to be_valid
      end
    end

    context '通らない' do
      describe 'name' do
        it '空だとNG' do
          client.name = ''
          expect(client).to be_invalid
        end

        it 'カブるとNG' do
          client.name = 'SAME_NAME'
          client.save
          dup = build(:client, name: 'SAME_NAME')
          expect(dup).to be_invalid
        end

        it '文字数が51文字以上だとNG' do
          client.name = 'ア' * 51
          expect(client).to be_invalid
        end
      end

      describe 'address' do
        it 'カブるとNG' do
          client.address = 'SAME_ADDRESS'
          client.save
          dup = build(:client, address: 'SAME_ADDRESS')
          expect(dup).to be_invalid
        end

        it '文字数が51文字以上だとNG' do
          client.address = 'ア' * 51
          expect(client).to be_invalid
        end
      end

      describe 'dispatching_fee_per_hour' do
        it '10000未満だとNG' do
          client.dispatching_fee_per_hour = 10000
          expect(client).to be_invalid
        end
      end
    end
  end
end
