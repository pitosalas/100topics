class Feed < ActiveRecord::Base
  belongs_to              :source
  belongs_to              :topic
  validates_presence_of   :url, :html_url, :name
end
