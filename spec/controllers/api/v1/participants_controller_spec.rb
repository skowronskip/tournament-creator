require 'rails_helper'

RSpec.describe Api::V1::ParticipantsController, type: :controller do
  describe '#index' do
    subject { get :index }

    describe 'successfull response' do
      before { subject }
      it { expect(response).to be_successful }
    end

    describe 'participants' do
      it 'should return all participants json' do
        participant1 = Participant.create(name: "Test name")
        participant2 = Participant.create(name: "Test name")
        expected_response = [participant1, participant2].to_json
        subject
        expect(JSON.parse(response.body)).to match_array(JSON.parse(expected_response))
      end
    end
  end

  describe '#create' do
    let(:valid_attributes) {
      { participant: {
          name: "Test name"
        }
      }
    }
    let(:invalid_attributes) {
      { participant: {
          name: "Definetely it is too long test name above fifty characters"
      }
      }
    }
    context 'valid params' do
      subject { post :create, params: valid_attributes }

      it 'should create new participant' do
        expect { subject }.to change{ Participant.count }.by(1)
      end

      it 'should new participant return new object' do
        new_participant = JSON.parse(subject.body)
        expect(new_participant["name"]).to include(valid_attributes[:participant][:name])
      end
    end

    context 'invalid params' do
      subject { post :create, params: invalid_attributes }

      it 'should not create new participant' do
        expect { subject }.not_to change{ Participant.count }
      end

      it 'should return `false` as error' do
        new_participant = JSON.parse(subject.body)
        expect(new_participant).to be_equal(false)
      end
    end
  end

  describe '#update' do
    let(:participant) {Participant.create({name: "Old test name"})}
    let(:new_name) {"Test name"}
    let(:valid_attributes) {
      {
          id: participant.id,
          participant: {
              name: new_name
          }
      }
    }
    let(:invalid_attributes) {
      {
          id: participant.id,
          participant: {

              name: "Definetely it is too long test name above fifty characters"
          }
      }
    }
    context 'valid params' do
      subject { patch :update, params: valid_attributes }

      it 'should edited participant return proper object' do
        new_participant = JSON.parse(subject.body)
        expect(new_participant["name"]).to include(valid_attributes[:participant][:name])
      end
    end

    context 'invalid params' do
      subject { patch :update, params: invalid_attributes }

      it 'should return `false` as error' do
        new_participant = JSON.parse(subject.body)
        expect(new_participant["name"]).to include("Old test name")
      end
    end
  end

  describe '#destroy' do
    let(:participant) { Participant.create({name: "Test name"})}
    subject { delete :destroy, params: { id: participant.id } }

    it 'should destroy message' do
      participant
      expect { subject }.to change{ Participant.count }.by(-1)
    end
  end
end
