class FeedsController < ApplicationController
  def index
    @sources = Source.find(:all, :order => 'name')
    @topics = Topic.find(:all, :order => 'name')
    @feeds = get_feeds(session[:feed_filter_source] || false,
                       session[:feed_filter_topic] || false)
  end
  
  # Selects feeds by given filter
  def select
    source = params[:source] || false
    topic = params[:topic] || false

    source = false if (source == '-1')
    topic = false if (topic == '-1')
    
    session[:feed_filter_source] = source
    session[:feed_filter_topic] = topic
    
    @feeds = get_feeds(source, topic)
    
    render :partial => 'feeds', :layout => false, :object => @feeds
  end
    
  # Save (add or update)
  def save
    if params[:command] == 'add'
      add
    else
      update
    end
  end
  
  # Deletes a feed
  def delete
    @id = params[:id]
    Feed.delete(@id)
  end
  
  # Starts editing of a feed
  def edit
    @id = params[:id]
    @feed = Feed.find(@id)
  end
  
  private

  # Adds new feed
  def add
    # Add feed
    find_or_add_topic
    @feed = Feed.new(params[:feed])

    @visible = @feed.save && is_visible?(@feed.id)
  end

  # Updates the feed
  def update
    @id = params[:id]
    @feed = Feed.find(@id)

    # Update the record    
    find_or_add_topic
    @feed.update_attributes(params[:feed])

    @visible = is_visible?(@id)
    @remove_previous = true
  end
    
  # Returns feeds by source, topic and id given
  def get_feeds(source, topic, id = false)
      cond = []
      cond << "1=1"
      cond << "source_id = #{source}" if source
      cond << "topic_id = #{topic}" if topic
      cond << "id = #{id}" if id
      
    return Feed.find(:all, :conditions => cond.join(' AND '))
  end

  # Finds or adds the topic if it's specified in a new topic line  
  def find_or_add_topic
    newTopic = params[:new_topic].strip
    if newTopic.length > 0
      topic = Topic.find_by_name(newTopic)
      if topic == nil
        topic = Topic.new(:name => newTopic, :slug => newTopic.downcase.gsub(/[^a-zA-Z0-9]/, '-'))
        topic.save
        
        @addedTopic = topic
      end

      params[:feed][:topic_id] = topic.id
    end
  end
  
  # Returns TRUE if a feed is currently visible
  def is_visible?(fid)
    feeds = get_feeds(
      session[:feed_filter_source] || false,
      session[:feed_filter_topic] || false,
      fid)
    return feeds.size > 0
  end
end
