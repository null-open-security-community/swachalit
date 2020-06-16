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
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index"
  add_index "audits", ["created_at"], name: "index_audits_on_created_at"
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid"
  add_index "audits", ["user_id", "user_type"], name: "user_index"

  create_table "chapter_leads", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chapter_id"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "chapter_leads", ["chapter_id"], name: "index_chapter_leads_on_chapter_id"
  add_index "chapter_leads", ["user_id"], name: "index_chapter_leads_on_user_id"

  create_table "chapters", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "code",               limit: 255
    t.text     "description",        limit: 2147483647
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "country",            limit: 255
    t.datetime "birthday"
    t.boolean  "active",                                default: true
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "chapter_email",      limit: 255
    t.string   "image",              limit: 255
    t.string   "twitter_handle",     limit: 255
    t.string   "facebook_profile",   limit: 255
    t.string   "linkedin_profile",   limit: 255
    t.string   "slideshare_profile", limit: 255
    t.string   "github_profile",     limit: 255
  end

  create_table "event_announcement_mailer_tasks", force: :cascade do |t|
    t.integer  "event_id"
    t.text     "recipients"
    t.text     "foot_note"
    t.boolean  "ready_for_delivery",             default: false
    t.boolean  "executed",                       default: false
    t.string   "status",             limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.text     "head_note"
  end

  create_table "event_automatic_notification_tasks", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "mode",       limit: 255
    t.boolean  "executed",               default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "event_mailer_tasks", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "subject",               limit: 255
    t.text     "body"
    t.boolean  "send_to_selected_only",             default: false
    t.boolean  "ready_for_delivery",                default: false
    t.boolean  "executed",                          default: false
    t.string   "status",                limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "registration_state",    limit: 255
  end

  create_table "event_registrations", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "visible",                default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "accepted"
    t.string   "state",      limit: 255
  end

  create_table "event_sessions", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "name",             limit: 255
    t.string   "session_type",     limit: 255
    t.text     "description"
    t.string   "tags",             limit: 255
    t.boolean  "need_projector",               default: false
    t.boolean  "need_microphone",              default: false
    t.boolean  "need_whiteboard",              default: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "slug",             limit: 255
    t.string   "presentation_url", limit: 255
    t.boolean  "placeholder",                  default: false
    t.string   "video_url",        limit: 255
  end

  add_index "event_sessions", ["slug"], name: "index_event_sessions_on_slug"

  create_table "event_types", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.text     "description"
    t.integer  "max_participant",                   default: 10000
    t.boolean  "public"
    t.boolean  "registration_required",             default: false
    t.boolean  "invitation_required",               default: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.text     "description"
    t.integer  "chapter_id"
    t.integer  "venue_id"
    t.integer  "event_type_id"
    t.boolean  "public"
    t.boolean  "can_show_on_homepage",                  default: true
    t.boolean  "can_show_on_archive",                   default: true
    t.boolean  "accepting_registration",                default: true
    t.string   "state",                     limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.datetime "registration_start_time"
    t.datetime "registration_end_time"
    t.text     "registration_instructions"
    t.string   "slug",                      limit: 255
    t.boolean  "ready_for_announcement",                default: false
    t.datetime "announced_at"
    t.boolean  "ready_for_notifications",               default: false
    t.datetime "notifications_sent_at"
    t.boolean  "ready_for_reminders"
    t.string   "calendar_event_id",         limit: 255
    t.string   "notification_state",        limit: 255
    t.integer  "max_registration"
  end

  add_index "events", ["slug"], name: "index_events_on_slug"

  create_table "jobs", force: :cascade do |t|
    t.string   "name",          limit: 32
    t.string   "type",          limit: 255
    t.string   "callback_path", limit: 1000
    t.integer  "state",                      default: 0
    t.binary   "params"
    t.binary   "response"
    t.string   "error_message", limit: 255
    t.text     "error_detail"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "page_access_permissions", force: :cascade do |t|
    t.string   "permission_type", limit: 255
    t.integer  "page_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description"
    t.string   "navigation_name", limit: 255
    t.string   "slug",            limit: 255
    t.string   "title",           limit: 255
    t.text     "content",         limit: 2147483647
    t.boolean  "published"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "session_proposals", force: :cascade do |t|
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.integer  "event_type_id"
    t.string   "session_topic",       limit: 255
    t.text     "session_description"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "session_requests", force: :cascade do |t|
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.string   "session_topic",       limit: 255
    t.text     "session_description"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "stats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context"
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id"
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type"
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id"

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "user_achievements", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "source",           limit: 255
    t.string   "achievement_type", limit: 255
    t.string   "info",             limit: 255
    t.string   "reference",        limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "user_api_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_agent",  limit: 255
    t.string   "client_name", limit: 255
    t.string   "ip_address",  limit: 255
    t.string   "token",       limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "active",                  default: false
    t.datetime "expire_at"
  end

  add_index "user_api_tokens", ["active"], name: "index_user_api_tokens_on_active"
  add_index "user_api_tokens", ["expire_at"], name: "index_user_api_tokens_on_expire_at"
  add_index "user_api_tokens", ["token"], name: "index_user_api_tokens_on_token"

  create_table "user_auth_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.binary   "oauth_data"
    t.binary   "extra"
    t.string   "uid",        limit: 255
    t.string   "provider",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",                    default: 0
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
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "homepage",               limit: 255
    t.text     "about_me"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "venues", force: :cascade do |t|
    t.integer  "chapter_id"
    t.string   "name",            limit: 255
    t.text     "description"
    t.text     "address"
    t.string   "map_url",         limit: 255
    t.text     "map_embedd_code"
    t.string   "contact_name",    limit: 255
    t.string   "contact_email",   limit: 255
    t.string   "contact_mobile",  limit: 255
    t.text     "contact_notes"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
