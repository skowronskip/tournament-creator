require 'rails_helper'
require 'faker'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#register' do
    let(:valid_attributes) {
      {
          email: Faker::Internet.email,
          login: Faker::Internet.user_name,
          password: "Test123!"
      }
    }
    let(:invalid_attributes) {
      {
          email: Faker::Internet.email
      }
    }

    context 'valid attributes' do
      subject { post :register, params: valid_attributes }

      it 'should create new user' do
        expect { subject }.to change{ User.count }.by(1)
      end

      it 'should new user return new object' do
        user = JSON.parse(subject.body)
        expect(user["message"]).to include("User created successfully")
      end
    end

    context 'invalid attributes' do
      subject { post :register, params: invalid_attributes }

      it 'should create new user' do
        expect { subject }.to change{ User.count }.by(0)
      end

    end
  end

  describe '#login' do
    let(:password) { "Test123!" }
    let(:user) { create(:user, password: password) }
    let(:valid_attributes) {
      {
          email: user.email,
          password: password
      }
    }

    context 'valid attributes' do
      subject { post :login, params: valid_attributes }

      it 'should return correct message' do
        expect(JSON.parse(subject.body)["message"]).to include("Login Successful")
      end
    end

  end
end
