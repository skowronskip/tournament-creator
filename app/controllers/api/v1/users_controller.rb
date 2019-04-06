class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]
  # POST /register
  def register
    check_mail = User.find_by(email: params[:email])
    check_login = User.find_by(login: params[:login])
    if check_mail
      render json: { message: 'Email already taken' }, status: :bad_request
    elsif check_login
      render json: { message: 'Login already taken' }, status: :bad_request
    else
      @user = User.new(user_params)
      if @user.save
        response = { message: 'User created successfully'}
        render json: response, status: :created
      else
        render json: @user.errors, status: :bad
      end
    end
  end

  def login
    authenticate params[:email], params[:password]
  end

  private

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      user = User.find_by(email: email)
      render json: {
          id: user.id,
          login: user.login,
          email: user.email,
          token: command.result,
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def user_params
    params.permit(
        :login,
        :email,
        :password
    )
  end
end
