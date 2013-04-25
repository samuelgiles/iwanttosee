class WishesController < ApplicationController

	def index

		if current_user

			@list = current_user.wishs.order("position")
			@newlist = current_user.wishs.new

			#Get users friendlist, use find_by to get them all if they exist
			@graph = Koala::Facebook::API.new(session[:token])

			friendslist = @graph.get_connections("me", "friends")
			@friends = User.includes(:wishs).where("uid IN (?)", friendslist)

		end 

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
