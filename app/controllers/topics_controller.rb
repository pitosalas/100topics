class TopicsController < ApplicationController
  def index
    @topics = Topic.find(:all)
  end

  def add
    @topic = Topic.new(params[:topic])
    if @topic.save
      @topic_row = render_to_string :partial => 'topic', :object => @topic, :locals => { :adding => true }
    end
  end
  
  def delete
    @id = params[:id]
    Topic.delete(@id)
  end
end
