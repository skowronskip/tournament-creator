require 'rails_helper'
 # TODO End this tests
RSpec.describe Api::V1::MatchesController, type: :controller do
  describe '#index' do
    subject { get :index }

    describe 'successfull response' do
      before { subject }
      it { expect(response).to be_successful }
    end

    describe 'matchs' do
      it 'should return all matchs json' do
        match1 = create(:match)
        match2 = create(:match)
        expected_response = [match1, match2].to_json
        subject
        expect(JSON.parse(response.body)).to match_array(JSON.parse(expected_response))
      end
    end
  end

  describe '#create' do
    let(:participant1) { create(:participant) }
    let(:participant2) { create(:participant) }
    let(:tournament) { create(:tournament) }
    let(:valid_attributes) {
      { match: {
          home_team_id: participant1.id,
          away_team_id: participant2.id,
          tournament_id: tournament.id
        }
      }
    }
    let(:invalid_attributes) {
      { match: {
          home_team_id: 99,
          away_team_id: 99,
          tournament_id: 99
        }
      }
    }
    context 'valid params' do
      subject { post :create, params: valid_attributes }

      it 'should create new match' do
        expect { subject }.to change{ Match.count }.by(1)
      end

      it 'should new match return new object' do
        new_match = JSON.parse(subject.body)
        expect(new_match["home_team_id"]).to be_equal(valid_attributes[:match][:home_team_id])
        expect(new_match["away_team_id"]).to be_equal(valid_attributes[:match][:away_team_id])
      end
    end

    context 'invalid params' do
      subject { post :create, params: invalid_attributes }

      it 'should not create new match' do
        expect { subject }.not_to change{ Match.count }
      end

      it 'should return `false` as error' do
        new_match = JSON.parse(subject.body)
        expect(new_match).to be_equal(false)
      end
    end
  end

  describe '#update' do
    let(:new_home_points) {3}
    let(:old_home_points) {2}
    let(:match) { create(:match, homePoints: old_home_points) }
    let(:valid_attributes) {
      {
          id: match.id,
          match: {
              homePoints: new_home_points
          }
      }
    }
    let(:invalid_attributes) {
      {
          id: match.id,
          match: {

              name: "Definetely it is too long test name above fifty characters"
          }
      }
    }
    context 'valid params' do
      subject { patch :update, params: valid_attributes }

      it 'should edited match return proper object' do
        new_match = JSON.parse(subject.body)
        expect(new_match["homePoints"]).to be_equal(valid_attributes[:match][:homePoints])
      end
    end

  end

  describe '#destroy' do
    let(:match) { create(:match) }
    subject { delete :destroy, params: { id: match.id } }

    it 'should destroy message' do
      match
      expect { subject }.to change{ Match.count }.by(-1)
    end
  end

  describe '#generate_matches' do
    let(:tournament) { create(:tournament) }
    let(:valid_attributes) {
      { tournament_id: tournament.id }
    }
    let(:invalid_attributes) {
      { tournament_id: 6 }
    }
    context 'valid attributes' do
      subject { post :generate_matches, params: valid_attributes }
      it 'should return list of created matches' do
        create(:participant, tournament_id: tournament.id)
        create(:participant, tournament_id: tournament.id)
        create(:participant, tournament_id: tournament.id)
        create(:participant, tournament_id: tournament.id)
        response = JSON.parse(subject.body)
        expect(response.length).to be_equal(6)
      end
      it 'should return error that participants not exists' do
        response = JSON.parse(subject.body)
        expect(response["error"]).to match("Tournament has no participants")
      end
    end
    context 'invalid attributes' do
      subject { post :generate_matches, params: invalid_attributes }
      it 'should return error that tournament id is wrong' do
        response = JSON.parse(subject.body)
        expect(response["error"]).to match("No such tournament")
      end
    end
    context 'no attributes' do
      subject { post :generate_matches, params: {} }
      it 'should return error that tournament id is wrong' do
        response = JSON.parse(subject.body)
        expect(response["error"]).to match("No tournament id")
      end
    end
  end
end
