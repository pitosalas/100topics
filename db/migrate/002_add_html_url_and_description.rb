class AddHtmlUrlAndDescription < ActiveRecord::Migration
  def self.up
    add_column :feeds, "html_url", :string, :null => false
    add_column :feeds, "description", :text
  end

  def self.down
    remove_column :feeds, "html_url"
    remove_column :feeds, "description"
  end
end
