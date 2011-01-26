class Source < ActiveRecord::Base
  belongs_to              :source_type
  has_many                :feeds, :dependent => :destroy
  validates_presence_of   :name, :slug
  validates_uniqueness_of :name, :slug
end
