require 'rails_helper'

RSpec.describe MatchesBetweenTeams do
  let(:tournament) { create(:tournament) }

  describe '#call' do
    it 'should return proper amount of matches for choosen participant' do
      participant1 = create(:participant, tournament_id: tournament.id)
      participant2 = create(:participant, tournament_id: tournament.id)
      participant3 = create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      participant_table = [participant1, participant2, participant3]
      participant_table = participant_table.map {|participant|
        calculator = CalculateTeamStatistics.new(participant, participant.as_home_team, participant.as_away_team)
        calculator.call
      }
      command = GenerateMatches.new(tournament.participants, tournament.id)
      command.call
      query = MatchesBetweenTeams.new(participant_table)
      result_teams = query.call
      result_teams.each do |team|
        expect(team[:home_matches].length + team[:away_matches].length).to be_equal(2)
      end
      expect(result_teams.length).to be_equal(3)
    end

    it 'should generate proper amount of matches for odd number of teamse' do
      query = MatchesBetweenTeams.new([])
      result = query.call
      expect(result.length).to be_equal(0)
    end
  end

end
