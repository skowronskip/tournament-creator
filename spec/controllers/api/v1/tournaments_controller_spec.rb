require 'rails_helper'

RSpec.describe Api::V1::TournamentsController, type: :controller do
  describe '#index' do
    subject { get :index }

    describe 'successfull response' do
      before { subject }
      it { expect(response).to be_successful }
    end

    describe 'tournaments' do
      it 'should return all tournaments json' do
        tournament1 = create(:tournament)
        tournament2 = create(:tournament)
        expected_response = [tournament1, tournament2].to_json
        subject
        expect(JSON.parse(response.body)).to match_array(JSON.parse(expected_response))
      end
    end
  end

  describe '#create' do
    let(:valid_attributes) {
      { tournament: {
          name: "Test name"
        }
      }
    }
    let(:invalid_attributes) {
      { tournament: {
          name: "Definetely it is too long test name above fifty characters"
      }
      }
    }
    context 'valid params' do
      subject { post :create, params: valid_attributes }

      it 'should create new tournament' do
        expect { subject }.to change{ Tournament.count }.by(1)
      end

      it 'should new tournament return new object' do
        new_tournament = JSON.parse(subject.body)
        expect(new_tournament["name"]).to include(valid_attributes[:tournament][:name])
      end
    end

    context 'invalid params' do
      subject { post :create, params: invalid_attributes }

      it 'should not create new tournament' do
        expect { subject }.not_to change{ Tournament.count }
      end

      it 'should return `false` as error' do
        new_tournament = JSON.parse(subject.body)
        expect(new_tournament).to be_equal(false)
      end
    end
  end

  describe '#update' do
    let(:new_name) {"Test name"}
    let(:old_name) {"Old test name"}
    let(:tournament) { create(:tournament, name: old_name) }
    let(:valid_attributes) {
      {
          id: tournament.id,
          tournament: {
              name: new_name
          }
      }
    }
    let(:invalid_attributes) {
      {
          id: tournament.id,
          tournament: {

              name: "Definetely it is too long test name above fifty characters"
          }
      }
    }
    context 'valid params' do
      subject { patch :update, params: valid_attributes }

      it 'should edited tournament return proper object' do
        new_tournament = JSON.parse(subject.body)
        expect(new_tournament["name"]).to include(valid_attributes[:tournament][:name])
      end
    end

    context 'invalid params' do
      subject { patch :update, params: invalid_attributes }

      it 'should return `false` as error' do
        new_tournament = JSON.parse(subject.body)
        expect(new_tournament["name"]).to include(old_name)
      end
    end
  end

  describe '#destroy' do
    let(:tournament) { create(:tournament) }
    subject { delete :destroy, params: { id: tournament.id } }

    it 'should destroy message' do
      tournament
      expect { subject }.to change{ Tournament.count }.by(-1)
    end
  end
end
