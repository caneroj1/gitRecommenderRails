require 'rails_helper'

RSpec.describe Repository, type: :model do
  let(:repository) { FactoryGirl.create(:repository) }

  context 'attributes' do
    it 'should have a readme_url' do
      expect(repository.readme_url).to_not be_nil
    end

    it 'should have some readme text' do
      expect(repository.readme_text).to_not be_nil
    end

    it 'should have a number of watchers' do
      expect(repository.watchers).to_not be_nil
    end

    it 'should have a pushed at date' do
      expect(repository.pushed_at).to_not be_nil
    end

    it 'should have a pushed at date' do
      expect(repository.pushed_at.class).to eq(ActiveSupport::TimeWithZone)
    end

    it 'should have an is private attribute' do
      expect(repository.is_private).to_not be_nil
    end

    it 'should have a languages hash' do
      expect(repository.languages.class).to eq(Hash)
    end

    it 'should have languages' do
      expect(repository.languages).to_not be_nil
    end
  end
end
