require 'rails_helper'

RSpec.describe CalculateTeamStatistics do
  let(:tournament) { create(:tournament) }

  describe '#call' do
    it 'should return proper calculated statistics' do
      participant1 = create(:participant, tournament_id: tournament.id)
      participant2 = create(:participant, tournament_id: tournament.id)
      participant3 = create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      command = GenerateMatches.new(tournament.participants, tournament.id)
      command.call
      matches = Match.where(home_team_id: [participant1.id, participant2.id], away_team_id: [participant1.id, participant2])
      matches.each do |match|
        Match.update(match.id, {homePoints: 1, awayPoints: 1})
      end
      [participant1, participant2].each do |participant|
        calculator = CalculateTeamStatistics.new(participant, participant.as_home_team, participant.as_away_team)
        result = calculator.call
        expect(result[:match_played]).to be_equal(1)
        expect(result[:match_won]).to be_equal(0)
        expect(result[:match_tied]).to be_equal(1)
        expect(result[:match_lost]).to be_equal(0)
        expect(result[:goals_scored]).to be_equal(1)
        expect(result[:goals_conceed]).to be_equal(1)
        expect(result[:goals_difference]).to be_equal(0)
      end
    end
  end
end
