require 'rails_helper'
require 'faker'

RSpec.describe OrderTeamsByAllConditions do
  let(:tournament) { create(:tournament) }

  describe '#call' do
    it 'should return proper calculated statistics' do
      participant1 = create(:participant, tournament_id: tournament.id)
      participant2 = create(:participant, tournament_id: tournament.id)
      participant3 = create(:participant, tournament_id: tournament.id)
      command = GenerateMatches.new(tournament.participants, tournament.id)
      command.call
      i = 1
      matches = tournament.matches
      matches.each do |match|
        if i == 1
          Match.update(match.id, {homePoints: 3, awayPoints: 0})
        else
          Match.update(match.id, {homePoints: i, awayPoints: i})
        end
        i += 1
      end
      calculated = [participant1, participant2, participant3].map do |participant|
        calculator = CalculateTeamStatistics.new(participant, participant.as_home_team, participant.as_away_team)
        calculator.call
      end
      order = OrderTeamsByAllConditions.new(calculated)
      result = order.call.flatten
      result = result.map do |team|
        {
            points: team[:points],
            ex_aequo_place: team[:ex_aequo_place]
        }
      end
      expect(result).to contain_exactly({points: 4, ex_aequo_place: 0}, {points: 2, ex_aequo_place: 0}, {points: 1, ex_aequo_place: 0})
    end
  end
end
