class MessagesController < ApplicationController

 
  def index
    @messages = Message.all
  end


  def show
    @message = Message.find(params[:id])
  end

  
  def new
    @message = Message.new
  end

 
  def edit
  end

 
  def create
    if request.content_type =~ /xml/
      params[:message] = Hash.from_xml(request.body.read)["message"]
      message = Message.create(message: params[:message])
      render xml:
      '<?xml version = "1.0" encoding = "UTF-8" standalone = "yes"?>' +
      '<url>' +
        message_url + message.slug + "/info" +
      '</url>'
    elsif request.content_type =~ /json/
      message = Message.create(message: params[:message])
      render json: {url: messages_url + "/" + message.id.to_s}
    elsif request.content_type =~ /form/
      @message = Message.new({message: params[:text1]})
     if @message.save
        redirect_to messages_url + "/" + @message.id.to_s + '/info'
      else
        render 'index'
      end
    end
   
  end

  def info
    render "info", locals: {url: messages_api_url + "/" + params[:id]}
		
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
   def set_note
      @message = Message.find(params[:id])

    end

  
    def message_params
      params.require(:message).permit(:content)
    end
     def message_api_params
      params.permit(:content)
    end
end
