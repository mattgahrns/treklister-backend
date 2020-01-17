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
        if trip.update(trip_params)
            render json: { message: 'Trip updated!',  trip: trip}
        else
            render json: { message: 'Trip could not be edited. Please try again.' }
        end
    end

    def destroy
        trip = Trip.find_by(id: params[:id])
        trip.destroy
        render json: { message: 'Trip deleted!' }
    end

    def lists
        trip = Trip.find_by(id: params[:id])
        before_list = List.where(["trip_id = ? and before = ?", trip.id, true])
        after_list = List.where(["trip_id = ? and before = ?", trip.id, false])
        before_items = ListItem.where("list_id = ?", before_list[0].id).order("created_at")
        after_items = ListItem.where("list_id = ?", after_list[0].id).order("created_at")
        render json: { before_items: before_items, after_items: after_items, before_list: before_list, after_list: after_list }
    end

    private
    def trip_params
        params.require(:trip).permit(:name, :description)
    end
end
