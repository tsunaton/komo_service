require "rails_helper"

RSpec.describe User, type: :model do
  #バリデーションについて
  describe "validations" do
    #存在性について
    describe "presence" do
      #nameがない時
      it "is be vaild" do
        user = User.new(name: "")
        expect(user).to be_invalid
      end
    end
  end
end
