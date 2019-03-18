require 'rails_helper'

RSpec.describe Match, type: :model do
  it 'should have proper attributes' do
    expect(subject.attributes).to include('home_team_id', 'away_team_id', 'homePoints', 'awayPoints', 'created_at', 'updated_at')
  end

  describe 'relations' do
    it { is_expected.to belong_to(:home_team) }
    it { is_expected.to belong_to(:away_team) }
  end
end
