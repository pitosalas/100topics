class SourceTypesController < ApplicationController

  def index
    @types = SourceType.find(:all)
  end

  def add
    @type = SourceType.new(params[:type])
    if @type.save
      @type_row = render_to_string :partial => 'type', :object => @type, :locals => { :adding => true }
    end
  end
  
  def delete
    @id = params[:id]
    type = SourceType.find(@id)
    if type.sources.size > 0
      @id = false
    else
      type.destroy
    end
  end
  
end
