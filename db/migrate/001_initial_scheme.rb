class InitialScheme < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.column "name", :string, :null => false
      t.column "slug", :string, :null => false
    end
    
    add_index(:topics, :name, :unique => true);
    add_index(:topics, :slug, :unique => true);
    
    create_table :source_types do |t|
      t.column "name", :string, :null => false
    end

    add_index(:source_types, :name, :unique => true);
    
    create_table :sources do |t|
      t.column "name", :string, :null => false
      t.column "slug", :string, :null => false
      t.column "source_type_id", :integer, :null => false
    end

    add_index(:sources, :name, :unique => true);
    add_index(:sources, :slug, :unique => true);
    
    create_table :feeds do |t|
      t.column "url", :string, :null => false
      t.column "name", :string, :null => false
      t.column "source_id", :integer, :null => false
      t.column "topic_id", :integer, :null => false
    end
  end

  def self.down
    drop_table :feeds
    drop_table :topics
    drop_table :sources
    drop_table :source_types
  end
end
