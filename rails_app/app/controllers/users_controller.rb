class UsersController < ApiController
  def create
    user = User.create(user_params)

    token = if user.valid?
              Knock::AuthToken.new(payload: user.to_token_payload)
            else
              nil
            end

    render json:  { token: token, errors: user.errors }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
