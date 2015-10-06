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
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:notice] = "Your message has been sent!"

    respond_to do |format|
      format.js
    end
  end
end
