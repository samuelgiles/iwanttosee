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

	def stats


		artistarray = Array.new

		if params[:mode] == "all"

			# Make an array of the artist names:
			sortdata = Wish.select("name")
			artistarray = sortdata.map(&:name)

			@mode = "all"

		else

			#Get users friendlist, use find_by to get them all if they exist
			@graph = Koala::Facebook::API.new(session[:token])
			#
			friendslist = @graph.get_connections("me", "friends")

			friendsarray = friendslist.collect do |friend|
				friend["id"]
			end

			@friends = User.includes(:wishs).where("uid IN (?)", friendsarray).map(&:id)


			# Make an array of the artist names:
			artistarray=(Wish.select("name").where("user_id IN (?)", @friends)).map(&:name)
			@mode = "friends"

			#TODO: Add own artists into the array

		end

		# Make a hash, the artist name will be used as the key
		@artisthash = Hash.new(0)

		# Loop through array, use the name as the key in the hash, +1 to that value
		artistarray.each do |artist|
			@artisthash[artist] += 1
		end

		@wishstats = (@artisthash.sort_by { |name, votes| votes }).reverse

	end

	def sort

		@responsejson = {
      	:success => "false"
    	}

		if params[:wish]
			(params[:wish]).each_with_index do |cWish,index|

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
