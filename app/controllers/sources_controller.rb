class SourcesController < ApplicationController

  def index
    @sources = Source.find(:all, :order => 'name')
  end
  
  def add
    @source = Source.new(params[:source])
    if @source.save
      @source_row = render_to_string :partial => 'source', :object => @source, :locals => { :adding => true }
    end
  end
  
  def delete
    @id = params[:id]
    Source.delete(@id)
  end
end
