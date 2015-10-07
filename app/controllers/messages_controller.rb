class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    recipients = User.where(id: params[:message][:recipient])
    if conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
      flash[:modal_success] = "Your message has been sent!"
    else
      flash[:modal_error] = "Sorry, there was a problem while sending your message."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
