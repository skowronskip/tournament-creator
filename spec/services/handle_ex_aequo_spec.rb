require 'rails_helper'
require 'faker'

RSpec.describe HandleExAequo do
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
        Match.update(match.id, {homePoints: i, awayPoints: i})
        i += 1
      end
      calculated = [participant1, participant2, participant3].map do |participant|
        calculator = CalculateTeamStatistics.new(participant, participant.as_home_team, participant.as_away_team)
        calculator.call
      end
      handler = HandleExAequo.new(calculated)
      result = handler.call
      result = result.map do |team|
        {
            goals_scored: team[:goals_scored],
            ex_aequo_place: team[:ex_aequo_place]
        }
      end
      expect(result).to contain_exactly({goals_scored: 5, ex_aequo_place: 1}, {goals_scored: 4, ex_aequo_place: 2}, {goals_scored: 3, ex_aequo_place: 3})
    end

    it 'should return proper calculated statistics with the same ex_aequo place' do
      participant1 = create(:participant, tournament_id: tournament.id)
      participant2 = create(:participant, tournament_id: tournament.id)
      participant3 = create(:participant, tournament_id: tournament.id)
      command = GenerateMatches.new(tournament.participants, tournament.id)
      command.call
      matches = tournament.matches
      matches.each do |match|
        Match.update(match.id, {homePoints: 1, awayPoints: 1})
      end
      calculated = [participant1, participant2, participant3].map do |participant|
        calculator = CalculateTeamStatistics.new(participant, participant.as_home_team, participant.as_away_team)
        calculator.call
      end
      handler = HandleExAequo.new(calculated)
      result = handler.call
      result = result.map do |team|
        {
            goals_scored: team[:goals_scored],
            ex_aequo_place: team[:ex_aequo_place]
        }
      end
      expect(result).to contain_exactly({goals_scored: 2, ex_aequo_place: 1}, {goals_scored: 2, ex_aequo_place: 1}, {goals_scored: 2, ex_aequo_place: 1})
    end
  end
end
