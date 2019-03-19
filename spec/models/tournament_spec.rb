require 'rails_helper'

RSpec.describe Tournament, type: :model do
  it 'should have proper attributes' do
    expect(subject.attributes).to include('name', 'created_at', 'updated_at')
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end
end
