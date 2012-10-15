class SessionsController < ApplicationController
  layout 'form'

  protect_from_forgery except: [:create_token, :pusher]
  skip_before_filter :login_api, only: [:ping, :create_token]

  # GET /ping
  def ping
    render status: 200, text: ""
  end

  # GET /login
  def new
    @user = User.new
  end

  # POST /sessions
  def create
    user = login(params[:user][:username], params[:user][:password], params[:user][:remember_me])

    if user
      redirect_back_or_to root_path
    else
      @user = User.new(params[:user])
      render :new, alert: "Username or password was invalid"
    end
  end

  # POST /login_token
  def create_token
    user = User.authenticate(params[:login] || "", params[:password] || "")

    if user
      render json: user.to_json(include: [:token])
    else
      render_unauthorized
    end
  end

  # POST /pusher/auth
  def pusher
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        user_id: current_user.id, # => required
        user_info: current_user.as_json
      })
      render json: response
    else
      render text: "Forbidden", status:'403'
    end
  end

  # DELETE /logout
  def destroy
    logout
    redirect_to root_path
  end
end
