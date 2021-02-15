class SubsController < ApplicationController

    def new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = params[:moderator_id]

        if @sub.save
        else
            flash[:errors] = @sub.errors.full_messages
        end
        redirect_to user_url(@sub.moderator)
    end

    def edit
        @sub = Sub.find_by[id: params[:id]]
        render :edit
    end

    def update
        @sub = Sub.find_by[id: params[:id]]
        if current_user == @sub.moderator && @sub && @sub.update(sub_params)
            redirect_to subs_url
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end    
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end

end
