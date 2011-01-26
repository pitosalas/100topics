class OpmlController < ApplicationController

  def index
    @sources = Source.find(:all, :order => 'name')
    @topics = Topic.find(:all, :order => 'name')
    
    @feeds = get_feeds(false, false)
  end

  def update_preview
    @sources = params[:sources].join("+")
    @topics = params[:topics].join("+")
    
    sources = params[:sources]
    sources = [] if (sources.size == 1 && sources[0] == '')
    
    topics = params[:topics]
    topics = [] if (topics.size == 1 && topics[0] == '')
    
    @link = url_for(:action => 'generate', :only_path => false) + "?topic=#{@topics}&source=#{@sources}"
    @feeds = get_feeds(to_sql_list(sources), to_sql_list(topics))
  end
  
  # Generates OPML
  def generate
    topics = params[:topic] || false
    sources = params[:source] || false
    
    topics = pre_process(topics)
    sources = pre_process(sources)

    @feeds = get_feeds(sources, topics)

    @sources = []
    @topics = []
    @feeds.each do |f|
      @sources << f.source.name
      @topics << f.topic.name
    end

    @topics.uniq!
    @sources.uniq!
    
    @headers["Content-Type"] = "text/plain"; #x-opml";
    render :layout => false
  end
  
  private
  
  def pre_process(a)
    if a
      a = a.split(' ')
      a = to_sql_list(a)
    end
    
    return a
  end

  def to_sql_list(a)
    a = a.collect() { |s| "'" + s + "'"}
    return a.join(', ');
  end
  
  # Returns feeds having given source/topic slugs  
  def get_feeds(sources, topics)
    cond = []
    cond << '1=1'
    cond << "topic_id IN (SELECT id FROM topics WHERE slug IN (#{topics}))" if (topics && topics.size > 0)
    cond << "source_id IN (SELECT id FROM sources WHERE slug IN (#{sources}))" if (sources && sources.size > 0)

    return Feed.find(:all, :conditions => cond.join(' AND '))
  end
end
