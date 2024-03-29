class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    render json: @messages
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    render json: @message
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    render json: @message
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    if @message.save
      MessageWorker.perform_async(@message.id)
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end
end
