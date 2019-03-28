require 'rails_helper'

RSpec.describe GenerateMatches do
  let(:tournament) { create(:tournament) }

  describe '#call' do
    it 'should generate proper amount of matches for even number of teamse' do
      create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      command = GenerateMatches.new(tournament.participants, tournament.id)
      expect{command.call}.to change{Match.count}.by(6)
    end

    it 'should generate proper amount of matches for odd number of teamse' do
      create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      create(:participant, tournament_id: tournament.id)
      command = GenerateMatches.new(tournament.participants, tournament.id)
      expect{command.call}.to change{Match.count}.by(10)
    end

    it 'should return error if tournament has already any match' do
      participant1 = create(:participant, tournament_id: tournament.id)
      participant2 = create(:participant, tournament_id: tournament.id)
      create(:match, home_team_id: participant1.id, away_team_id: participant2.id, tournament_id: tournament.id)
      command = GenerateMatches.new(tournament.participants, tournament.id)
      expect(command.call[:error]).to match("Tournament has already generated matches")
    end
  end

end
