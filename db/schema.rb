# for auto_migrations

ActiveRecord::Schema.define(:version => 20110928162310) do

  create_table "attachments", :force => true do |t|
    t.text     "description"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "up_votes",   :default => 0, :null => false
    t.integer  "down_votes", :default => 0, :null => false
    t.string   "body_html"
    t.integer  "user_id"
    t.string   "item_id"
  end

  add_index "entries", ["state"], :name => "index_entries_on_state"

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",   :null => false
    t.string   "followable_type", :null => false
    t.integer  "follower_id",     :null => false
    t.string   "follower_type",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["key"], :name => "index_items_on_key"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "timeline_events", :force => true do |t|
    t.string   "event_type"
    t.string   "subject_type"
    t.string   "actor_type"
    t.string   "secondary_subject_type"
    t.integer  "subject_id"
    t.integer  "actor_id"
    t.integer  "secondary_subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.database_authenticatable :null => false
    t.recoverable
    t.rememberable
    t.trackable
    # t.encryptable
    t.confirmable
    # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
    # t.token_authenticatable
    t.timestamps
    t.integer :up_votes, :null => false, :default => 0
    t.integer :down_votes, :null => false, :default => 0
    t.string   "name"
  end

  add_index :users, :email,                :unique => true
  add_index :users, :reset_password_token, :unique => true
  add_index :users, :confirmation_token,   :unique => true
  # add_index :users, :unlock_token,         :unique => true
  # add_index :users, :authentication_token, :unique => true

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
