class GiftsController < ApplicationController

  get "/gifts" do
    if logged_in?
    @gifts = current_user.gifts
      erb :"gifts/gifts"
    else
    flash[:error] = "Please log in"
    redirect to "/login"
    end
  end

  get "/gifts/new" do
    if logged_in?
    erb :"gifts/create_gift"
    else
      flash[:error] = "Please log in"
    redirect to "/login"
    end
  end

  post "/gifts" do
    if !params[:name].empty?
      @gift = Gift.create(name: params[:name], where_to_buy: params[:where_to_buy], recipient: params[:recipient], notes: params[:notes])
      @gift.user_id = session[:user_id]
      @gift.save
        flash[:success] = "You successfully created a new gift!"
      redirect to "/gifts/#{@gift.id}"
    else
      flash[:error] = "Please make sure you fill in a gift name."
      redirect to "/gifts/new"
    end
  end

  get "/gifts/:id" do

    if logged_in?
      @gift = Gift.find_by(id: params[:id])
      if @gift && @gift.user == current_user
        erb :"gifts/show_gift"
      else
        redirect to "/gifts"
      end
    else
      flash[:error] = "Please log in"
      redirect to "/login"
    end
  end

  get "/gifts/:id/edit" do
    if logged_in?
      @gift = Gift.find_by_id(params[:id])
      if @gift && @gift.user == current_user
        erb :"gifts/edit_gift"
      else
        redirect to "/gifts"
      end
    else
      flash[:error] = "Please log in"
      redirect to "/login"
    end
  end

  post "/gifts/:id" do
    if logged_in?
     @gift = Gift.find_by_id(params[:id])
     @gift.name = params[:name]
     @gift.where_to_buy = params[:where_to_buy]
     @gift.recipient = params[:recipient]
     @gift.notes = params[:notes]
     @gift.user_id = session[:user_id]
     @gift.save
     flash[:success] = "Your changes were successful!"
     redirect "/gifts/#{@gift.id}"
   else
       flash[:error] = "Please log in"
     redirect to "/login"
   end
  end

  get "/gifts/:id/delete" do
    if logged_in?
      @gift = Gift.delete(params[:id])
         flash[:success] = "Your gift has been deleted."
      redirect to '/gifts'
    else
        flash[:error] = "Please log in"
      redirect to '/login'
    end
  end

end
