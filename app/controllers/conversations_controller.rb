class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index]
  before_action :get_box, only: [:index]
  before_action :get_conversation, except: [:index, :empty_trash]

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox.paginate(page: params[:page], per_page: 10)
    else
      @conversations = @mailbox.trash.paginate(page: params[:page], per_page: 10)
    end
    @new_message_count = count_new_messages
    @no_message_text = no_message_text
  end

  def show
    @conversation.mark_as_read(current_user) if @conversation.is_unread?(current_user)
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    @receipt = @conversation.receipts_for(current_user).last

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:notice] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def restore
    @conversation.untrash(current_user)
    flash[:notice] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:notice] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end

  # def mark_as_read
  #   @conversation.mark_as_read(current_user)
  #   flash[:success] = 'The conversation was marked as read.'
  #   redirect_to conversations_path
  # end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def get_box
    if params[:box].blank? or !["inbox","sent","trash"].include?(params[:box])
      params[:box] = 'inbox'
    end
    @box = params[:box]
  end

  def count_new_messages
    @mailbox.receipts.where(is_read: false).count
  end

  def no_message_text
    case @box
      when 'inbox' then 'You do not have any messages...'
      when 'sent' then 'You have not sent any messages...'
      when 'trash' then 'Your trash is empty...'
    end
  end
end
