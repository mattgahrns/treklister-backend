class ListItemsController < ApplicationController
    def create
        list_item = ListItem.new(list_item_params)
        list = List.find_by(id: params[:id])
        # byebug
        list_item.list_id = list.id
        if list_item.save
            render json: list_item
        else
            render json: { message: 'List Item could not be created. Please try again.' }
        end
    end

    def update
        list_item = Item.find_by(id: params[:id])
        if list_item.update(list_item_params)
            render json: { message: 'List Item updated!' }
        else
            render json: { message: 'List Item could not be edited. Please try again.' }
        end
    end

    def destroy
        list_item = Item.find_by(id: params[:id])
        list_item.destroy
    end

    private
    def list_item_params
        params.require(:list_item).permit(:content)
    end
end
