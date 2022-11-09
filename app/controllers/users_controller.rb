class UsersController < ApplicationController
  skip_before_action(:force_user_sign_in, {:only => [:index]})

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "users/index.html.erb" })
  end
  
  def show
    the_id = params.fetch("path_id")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    # # bring data from follow request to render here
    matching_follow_requests = FollowRequest.where({ :sender_id => @current_user.id , :recipient_id => @the_user.id })
    # narrow down to the specific request
    a_follow_request = matching_follow_requests.at(0)

  if @the_user.private == true && @current_user.username == @the_user.username
    render({ :template => "users/show.html.erb" })

  elsif @the_user.private == true && !a_follow_request
    redirect_to("/", { :alert => "You're not authorized for that." })

  elsif @the_user.private == true && a_follow_request == nil 
    redirect_to("/", { :alert => "You're not authorized for that." })

  elsif @the_user.private == true && a_follow_request.status == "pending"
      redirect_to("/", { :alert => "You're not authorized for that." })

  elsif  @the_user.private == true && a_follow_request.status == "rejected"
    redirect_to("/", { :alert => "You're not authorized for that." })

  elsif @the_user.private == false && !a_follow_request
    render({ :template => "users/show.html.erb" })
    
  elsif  @the_user.private == false && a_follow_request.status == "rejected"
    redirect_to("/", { :alert => "You're not authorized for that." })  

  else
      render({ :template => "users/show.html.erb" })
    end
  end    
end   
