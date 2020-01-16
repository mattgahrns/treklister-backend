class ListsController < ApplicationController

    def uncheck_all
        list = List.find_by(id: params[:id])
        list_items = ListItem.where('list_id = ?',  list.id).order("created_at")
        list_items.each do |item|
            item.isChecked = false
            item.save
        end
        
        render json: { list_items: list_items, list: list }
    end
end
