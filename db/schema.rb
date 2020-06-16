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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200616165558) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id",    limit: 4
    t.string   "auditable_type",  limit: 255
    t.integer  "associated_id",   limit: 4
    t.string   "associated_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.string   "user_type",       limit: 255
    t.string   "username",        limit: 255
    t.string   "action",          limit: 255
    t.text     "audited_changes", limit: 65535
    t.integer  "version",         limit: 4,     default: 0
    t.string   "comment",         limit: 255
    t.string   "remote_address",  limit: 255
    t.string   "request_uuid",    limit: 255
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "chapter_leads", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "chapter_id", limit: 4
    t.boolean  "active",               default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chapter_leads", ["chapter_id"], name: "index_chapter_leads_on_chapter_id", using: :btree
  add_index "chapter_leads", ["user_id"], name: "index_chapter_leads_on_user_id", using: :btree

  create_table "chapters", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "code",               limit: 255
    t.text     "description",        limit: 4294967295
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "country",            limit: 255
    t.datetime "birthday"
    t.boolean  "active",                                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "chapter_email",      limit: 255
    t.string   "image",              limit: 255
    t.string   "twitter_handle",     limit: 255
    t.string   "facebook_profile",   limit: 255
    t.string   "linkedin_profile",   limit: 255
    t.string   "slideshare_profile", limit: 255
    t.string   "github_profile",     limit: 255
  end

  create_table "event_announcement_mailer_tasks", force: :cascade do |t|
    t.integer  "event_id",           limit: 4
    t.text     "recipients",         limit: 65535
    t.text     "foot_note",          limit: 65535
    t.boolean  "ready_for_delivery",               default: false
    t.boolean  "executed",                         default: false
    t.string   "status",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "head_note",          limit: 65535
  end

  create_table "event_automatic_notification_tasks", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.string   "mode",       limit: 255
    t.boolean  "executed",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_mailer_tasks", force: :cascade do |t|
    t.integer  "event_id",              limit: 4
    t.string   "subject",               limit: 255
    t.text     "body",                  limit: 65535
    t.boolean  "send_to_selected_only",               default: false
    t.boolean  "ready_for_delivery",                  default: false
    t.boolean  "executed",                            default: false
    t.string   "status",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "registration_state",    limit: 255
  end

  create_table "event_registrations", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "visible",                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
    t.string   "state",      limit: 255
  end

  create_table "event_sessions", force: :cascade do |t|
    t.integer  "event_id",         limit: 4
    t.integer  "user_id",          limit: 4
    t.string   "name",             limit: 255
    t.string   "session_type",     limit: 255
    t.text     "description",      limit: 65535
    t.string   "tags",             limit: 255
    t.boolean  "need_projector",                 default: false
    t.boolean  "need_microphone",                default: false
    t.boolean  "need_whiteboard",                default: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",             limit: 255
    t.string   "presentation_url", limit: 255
    t.boolean  "placeholder",                    default: false
    t.string   "video_url",        limit: 255
  end

  add_index "event_sessions", ["slug"], name: "index_event_sessions_on_slug", using: :btree

  create_table "event_types", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.text     "description",           limit: 65535
    t.integer  "max_participant",       limit: 4,     default: 10000
    t.boolean  "public"
    t.boolean  "registration_required",               default: false
    t.boolean  "invitation_required",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.text     "description",               limit: 65535
    t.integer  "chapter_id",                limit: 4
    t.integer  "venue_id",                  limit: 4
    t.integer  "event_type_id",             limit: 4
    t.boolean  "public"
    t.boolean  "can_show_on_homepage",                    default: true
    t.boolean  "can_show_on_archive",                     default: true
    t.boolean  "accepting_registration",                  default: true
    t.string   "state",                     limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "registration_start_time"
    t.datetime "registration_end_time"
    t.text     "registration_instructions", limit: 65535
    t.string   "slug",                      limit: 255
    t.boolean  "ready_for_announcement",                  default: false
    t.datetime "announced_at"
    t.boolean  "ready_for_notifications",                 default: false
    t.datetime "notifications_sent_at"
    t.boolean  "ready_for_reminders"
    t.string   "calendar_event_id",         limit: 255
    t.string   "notification_state",        limit: 255
    t.integer  "max_registration",          limit: 4
  end

  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "name",          limit: 32
    t.string   "type",          limit: 255
    t.string   "callback_path", limit: 1000
    t.integer  "state",         limit: 4,     default: 0
    t.binary   "params",        limit: 65535
    t.binary   "response",      limit: 65535
    t.string   "error_message", limit: 255
    t.text     "error_detail",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_access_permissions", force: :cascade do |t|
    t.string   "permission_type", limit: 255
    t.integer  "page_id",         limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.string   "navigation_name", limit: 255
    t.string   "slug",            limit: 255
    t.string   "title",           limit: 255
    t.text     "content",         limit: 4294967295
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_proposals", force: :cascade do |t|
    t.integer  "chapter_id",          limit: 4
    t.integer  "user_id",             limit: 4
    t.integer  "event_type_id",       limit: 4
    t.string   "session_topic",       limit: 255
    t.text     "session_description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_requests", force: :cascade do |t|
    t.integer  "chapter_id",          limit: 4
    t.integer  "user_id",             limit: 4
    t.string   "session_topic",       limit: 255
    t.text     "session_description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "stats", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_achievements", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "source",           limit: 255
    t.string   "achievement_type", limit: 255
    t.string   "info",             limit: 255
    t.string   "reference",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_api_tokens", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "user_agent",  limit: 255
    t.string   "client_name", limit: 255
    t.string   "ip_address",  limit: 255
    t.string   "token",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                  default: false
    t.datetime "expire_at"
  end

  add_index "user_api_tokens", ["active"], name: "index_user_api_tokens_on_active", using: :btree
  add_index "user_api_tokens", ["expire_at"], name: "index_user_api_tokens_on_expire_at", using: :btree
  add_index "user_api_tokens", ["token"], name: "index_user_api_tokens_on_token", using: :btree

  create_table "user_auth_profiles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.binary   "oauth_data", limit: 65535
    t.binary   "extra",      limit: 65535
    t.string   "uid",        limit: 255
    t.string   "provider",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,     default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "name",                   limit: 255
    t.string   "handle",                 limit: 255
    t.string   "twitter_handle",         limit: 255
    t.string   "facebook_profile",       limit: 255
    t.string   "linkedin_profile",       limit: 255
    t.string   "slideshare_profile",     limit: 255
    t.string   "github_profile",         limit: 255
    t.string   "avatar",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "homepage",               limit: 255
    t.text     "about_me",               limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.integer  "chapter_id",      limit: 4
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.text     "address",         limit: 65535
    t.string   "map_url",         limit: 255
    t.text     "map_embedd_code", limit: 65535
    t.string   "contact_name",    limit: 255
    t.string   "contact_email",   limit: 255
    t.string   "contact_mobile",  limit: 255
    t.text     "contact_notes",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
