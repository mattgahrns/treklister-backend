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
            render json: { error: 'Failed to create user, username already taken!'}, status: :not_acceptable
        end
    end

    def trips
        user = User.find_by(id: params[:id])
        trips = Trip.where(user_id: user.id)
        render json: trips
    end

    def update
        user = User.find_by(id: params[:id])
        if user.update(user_params)
            render json: { message: 'User updated!', user: user }
        else
            render json: { message: 'User could not be edited. Please try again.' }
        end
    end

    def change_password
        user = User.find_by(id: params[:id])
        if user.update(user_params)
            render json: { message: 'Password updated!'}
        else
            render json: { message: 'Password could not be updated. Please try again.' }
        end
    end

    def destroy
        user = User.find_by(id: params[:id])
        user.destroy
        render json: { message: 'Account deleted!' }
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :password)
    end
end
