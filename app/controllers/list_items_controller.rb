class ListItemsController < ApplicationController
    def create
        list_item = ListItem.new(list_item_params)
        list = List.find_by(id: params[:id])
        list_item.list_id = list.id
        list_item.isChecked = false
        if list_item.save
            render json: list_item
        else
            render json: { message: 'List Item could not be created. Please try again.' }
        end
    end

    def show
        list_item = ListItem.find_by(id: params[:id])
        render json: list_item 
    end

    def check
        list_item = ListItem.find_by(id: params[:id])
        if list_item.isChecked == true
            list_item.isChecked = false
        else
            list_item.isChecked = true
        end
    end

    def update
        list_item = ListItem.find_by(id: params[:id])
        if list_item.update(list_item_params)
            render json: { message: 'List Item updated!', list_item: list_item }
        else
            render json: { message: 'List Item could not be edited. Please try again.' }
        end
    end

    def destroy
        list_item = ListItem.find_by(id: params[:id])
        list = List.find_by(id: list_item.list_id)
        list_item.destroy
        list_items = ListItem.where('list_id = ?',  list.id)
        render json: { list_items: list_items, list: list }
    end

    private
    def list_item_params
        params.require(:list_item).permit(:content)
    end
end
