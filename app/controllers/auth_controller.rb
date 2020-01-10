class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @user = User.find_by(username: user_login_params[:username])
        if @user && @user.authenticate(user_login_params[:password])
            token = encode_token({ user_id: @user.id})
            render json: { user: @user, jwt: token }, status: :accepted
        else
            render json: { message: 'Invalid username or password!', error: "invalid username or password" }, status: :unauthorized
        end
    end

    def show
        user = User.find_by(id: user_id)
        if logged_in?
          render json: {
                id: user.id,
                username: user.username,
                first_name: user.first_name,
                last_name: user.last_name,
            }
        else
          render json: {error: 'No user could be found'}, status: 401
        end
    end

    private
    def user_login_params
        params.require(:user).permit(:username, :password)
    end
end
