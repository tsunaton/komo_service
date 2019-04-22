require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = build(:user)
  end

  describe 'バリデーション' do


    context "通る" do

      it 'OK' do
        expect(@user).to be_valid
      end

    end


    context "通らない" do

      it 'nameが空だとNG' do
        @user.name = ''
        expect(@user).to be_invalid
      end

      it 'nameの文字数が51文字以上だとNG' do
        @user.email = 'ア' * 51
        expect(@user).to be_invalid
      end

      it 'emailが空だとNG' do
        @user.email = ''
        expect(@user).to be_invalid
      end

      it 'emailの文字数が256文字以上だとNG' do
        @user.email = 'ア' * 255 + "@example.com"
        expect(@user).to be_invalid
      end

      it 'emailがフォーマットに沿っていないとNG 1' do
        @user.email = "exampleexample.com"
        expect(@user).to be_invalid
      end

      it 'emailがフォーマットに沿っていないとNG 2' do
        @user.email = "example@examplecom"
        expect(@user).to be_invalid
      end

      it 'emailがカブるとNG' do
        @user.email = 'TEST_NAME1'
        expect(@user).to be_invalid
      end

      it 'addressの文字数が51文字以上だとNG' do
        @user.email = 'ア' * 51
        expect(@user).to be_invalid
      end

      it 'nearest_stationの文字数が51文字以上だとNG' do
        @user.email = 'ア' * 51
        expect(@user).to be_invalid
      end

    end
  end
end
