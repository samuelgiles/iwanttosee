class WishesController < ApplicationController

	def index

		if current_user

			@list = current_user.wishs.order("position")
			@newlist = current_user.wishs.new

			#Get users friendlist, use find_by to get them all if they exist
			@graph = Koala::Facebook::API.new(session[:token])
			#
			friendslist = @graph.get_connections("me", "friends")

			friendsarray = friendslist.collect do |friend|
				friend["id"]
			end

			@friends = User.includes(:wishs).where("uid IN (?)", friendsarray)

		end 

	end

	def edit

	end

	def remove

	end

	def sort

		@responsejson = {
      	:success => "false"
    	}

		if params[:wish]
			(params[:wish].reverse!).each_with_index do |cWish,index|

			    Wish.update(cWish, :position => index+1)

		    end

		    @responsejson[:success] = "true"
		end

		render :json => @responsejson

	end

	def create

		@sortorder = current_user.wishs.maximum(:position)
	    if !@sortorder
	      @sortorder = 1
	    else
	      @sortorder = @sortorder + 1
	    end


	    @list = current_user.wishs.new({"name" => params[:title], "position" => @sortorder})

	    if(@list.save)
	    	redirect_to :root
	    else
	    	redirect_to :error
	    end

	end

	def error

	end

end
