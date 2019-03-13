# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20181227141446) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "chapter_leads", :force => true do |t|
    t.integer  "user_id"
    t.integer  "chapter_id"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "chapter_leads", ["chapter_id"], :name => "index_chapter_leads_on_chapter_id"
  add_index "chapter_leads", ["user_id"], :name => "index_chapter_leads_on_user_id"

  create_table "chapters", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description",        :limit => 2147483647
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "birthday"
    t.boolean  "active",                                   :default => true
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "chapter_email"
    t.string   "image"
    t.string   "twitter_handle"
    t.string   "facebook_profile"
    t.string   "linkedin_profile"
    t.string   "slideshare_profile"
    t.string   "github_profile"
  end

  create_table "event_announcement_mailer_tasks", :force => true do |t|
    t.integer  "event_id"
    t.text     "recipients"
    t.text     "foot_note"
    t.boolean  "ready_for_delivery", :default => false
    t.boolean  "executed",           :default => false
    t.string   "status"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.text     "head_note"
  end

  create_table "event_automatic_notification_tasks", :force => true do |t|
    t.integer  "event_id"
    t.string   "mode"
    t.boolean  "executed",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "event_mailer_tasks", :force => true do |t|
    t.integer  "event_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "send_to_selected_only", :default => false
    t.boolean  "ready_for_delivery",    :default => false
    t.boolean  "executed",              :default => false
    t.string   "status"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "registration_state"
  end

  create_table "event_registrations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "visible",       :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "accepted"
    t.string   "state"
    t.string   "gov_id_type"
    t.string   "gov_id_number"
  end

  create_table "event_sessions", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "session_type"
    t.text     "description"
    t.string   "tags"
    t.boolean  "need_projector",   :default => false
    t.boolean  "need_microphone",  :default => false
    t.boolean  "need_whiteboard",  :default => false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "slug"
    t.string   "presentation_url"
    t.boolean  "placeholder",      :default => false
    t.string   "video_url"
  end

  add_index "event_sessions", ["slug"], :name => "index_event_sessions_on_slug"

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "max_participant",       :default => 10000
    t.boolean  "public"
    t.boolean  "registration_required", :default => false
    t.boolean  "invitation_required",   :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "chapter_id"
    t.integer  "venue_id"
    t.integer  "event_type_id"
    t.boolean  "public"
    t.boolean  "can_show_on_homepage",      :default => true
    t.boolean  "can_show_on_archive",       :default => true
    t.boolean  "accepting_registration",    :default => true
    t.string   "state"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.datetime "registration_start_time"
    t.datetime "registration_end_time"
    t.text     "registration_instructions"
    t.string   "slug"
    t.boolean  "ready_for_announcement",    :default => false
    t.datetime "announced_at"
    t.boolean  "ready_for_notifications",   :default => false
    t.datetime "notifications_sent_at"
    t.boolean  "ready_for_reminders"
    t.string   "calendar_event_id"
    t.string   "notification_state"
    t.integer  "max_registration"
  end

  add_index "events", ["slug"], :name => "index_events_on_slug"

  create_table "jobs", :force => true do |t|
    t.string   "name",          :limit => 32
    t.string   "type"
    t.string   "callback_path", :limit => 1000
    t.integer  "state",                         :default => 0
    t.binary   "params"
    t.binary   "response"
    t.string   "error_message"
    t.text     "error_detail"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "page_access_permissions", :force => true do |t|
    t.string   "permission_type"
    t.integer  "page_id"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "navigation_name"
    t.string   "slug"
    t.string   "title"
    t.text     "content",         :limit => 2147483647
    t.boolean  "published"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "session_proposals", :force => true do |t|
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.integer  "event_type_id"
    t.string   "session_topic"
    t.text     "session_description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "session_requests", :force => true do |t|
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.string   "session_topic"
    t.text     "session_description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stats", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_achievements", :force => true do |t|
    t.integer  "user_id"
    t.string   "source"
    t.string   "achievement_type"
    t.string   "info"
    t.string   "reference"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "user_api_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_agent"
    t.string   "client_name"
    t.string   "ip_address"
    t.string   "token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_auth_profiles", :force => true do |t|
    t.integer  "user_id"
    t.binary   "oauth_data"
    t.binary   "extra"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name"
    t.string   "handle"
    t.string   "twitter_handle"
    t.string   "facebook_profile"
    t.string   "linkedin_profile"
    t.string   "slideshare_profile"
    t.string   "github_profile"
    t.string   "avatar"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "homepage"
    t.text     "about_me"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.integer  "chapter_id"
    t.string   "name"
    t.text     "description"
    t.text     "address"
    t.string   "map_url"
    t.text     "map_embedd_code"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_mobile"
    t.text     "contact_notes"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
