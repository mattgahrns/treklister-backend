class TripsController < ApplicationController

    def create
        trip = Trip.new(trip_params)
        user = User.find_by(id: params[:id])
        trip.user_id = user.id
        if trip.save
            beforeList = List.create(before: true, trip_id: trip.id)
            afterList = List.create(before: false, trip_id: trip.id)
            render json: trip, include: [:user]
        else
            render json: { message: 'Post could not be created. Please try again.' }
        end
    end

    def show
        trip = Trip.find_by(id: params[:id])
        render json: trip, include: [:user]
    end

    def update
        trip = Trip.find_by(id: params[:id])
        if ptripupdate(trip_params)
            render json: { message: 'Trip updated!' }
        else
            render json: { message: 'Trip could not be edited. Please try again.' }
        end
    end

    def destroy
        trip = Trip.find_by(id: params[:id])
        trip.destroy
    end

    private
    def trip_params
        params.require(:trip).permit(:name)
    end
end
