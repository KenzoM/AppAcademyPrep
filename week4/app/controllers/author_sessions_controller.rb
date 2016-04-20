class AuthorSessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_to(articles_path, notice: 'Logged in successfully.') #changed from redirect_back_or_to
    else
      # flash.now.alert = "Login failed."
      # render action: :new
      redirect_to(login_path, notice: 'Login failed!')
    end
  end

  def destroy
    logout
    redirect_to(:authors, notice: 'Logged out!')
  end
end
