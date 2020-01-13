class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def profile
        render json: { user: current_user }, status: :accepted
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            @token = encode_token(user_id: @user.id)
            render json: { user: @user,
            jwt: @token }, status: :created
        else
            render json: { error: 'failed to create user'}, status: :not_acceptable
        end
    end

    def trips
        user = User.find_by(id: params[:id])
        trips = Trip.where(user_id: user.id)
        render json: trips
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :password)
    end
end
