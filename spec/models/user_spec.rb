require "rails_helper"

RSpec.describe User do
  let(:user) { FactoryGirl.create(:user) }

  context 'attributes' do
    it 'should have a login' do
      expect(user.login).to_not be_nil
    end

    it 'should have a github id' do
      expect(user.github_id).to_not be_nil
    end

    describe 'keywords' do
      it 'can have five keywords' do
        %w{one two three four five}.each do |keyword|
          expect(user.send("keyword_#{keyword}".to_sym)).to_not be_nil
        end
      end
    end
  end
end
