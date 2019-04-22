require 'rails_helper'

RSpec.describe Client, type: :model do

  before do
    @client = build(:client)
  end

  describe 'バリデーション' do


    context "通る" do

      # it 'OK' do
      #   expect(@client).to be_valid
      # end

    end


    context "通らない" do

      describe "name" do

        it 'nameが空だとNG' do
          @client.name = ''
          expect(@client).to be_invalid
        end

        it 'nameがカブるとNG' do
          @client.name = 'TEST_NAME1'
          expect(@client).to be_invalid
        end

        it 'nameの文字数が51文字以上だとNG' do
          @client.name = 'ア' * 51
          expect(@client).to be_invalid
        end

      end
      describe "address" do

        it 'addressの文字数が51文字以上だとNG' do
          @client.address = 'ア' * 51
          expect(@client).to be_invalid
        end

        it 'addressがカブるとNG' do
          @client.address = 'テスト県テスト市テスト区1番地'
          expect(@client).to be_invalid
        end

      end
      describe "dispatching_fee_per_hour" do

        it 'dispatching_fee_per_hourが10001以上だとNG' do
          @client.dispatching_fee_per_hour = 10001
          expect(@client).to be_invalid
        end

      end

    end
  end
end
