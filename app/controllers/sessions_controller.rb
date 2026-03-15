class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })

    if @user != nil
      entered_password = params["password"]
      real_password = BCrypt::Password.new(@user["password_digest"])

      if real_password == entered_password
        session["user_id"] = @user["id"]
        redirect_to "/"
        return
      end
    end

    redirect_to "/login"
  end

  def destroy
    session["user_id"] = nil
    redirect_to "/"
  end
end