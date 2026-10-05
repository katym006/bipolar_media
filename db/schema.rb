# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_05_210139) do
  create_table "article_tags", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_tags_on_article_id"
    t.index ["tag_id"], name: "index_article_tags_on_tag_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "summary"
    t.text "body"
    t.string "content_kind"
    t.string "audience"
    t.string "source_url"
    t.boolean "expert_reviewed"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
    t.index ["author_id"], name: "index_articles_on_author_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mood_entries", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.date "entry_date"
    t.integer "mood_level"
    t.integer "energy_level"
    t.decimal "sleep_hours", precision: 4, scale: 1
    t.string "emotions"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id", "entry_date"], name: "index_mood_entries_on_profile_id_and_entry_date", unique: true
    t.index ["profile_id"], name: "index_mood_entries_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "city_id"
    t.boolean "daily_reminder", default: false, null: false
    t.string "display_name"
    t.string "avatar"
    t.date "birth_date"
    t.date "diagnosed_at"
    t.time "reminder_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_profiles_on_city_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer "test_attempt_id", null: false
    t.integer "article_id", null: false
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_recommendations_on_article_id"
    t.index ["test_attempt_id"], name: "index_recommendations_on_test_attempt_id"
  end

  create_table "screening_tests", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialists", force: :cascade do |t|
    t.string "full_name"
    t.string "specialty"
    t.integer "city_id", null: false
    t.text "contacts"
    t.decimal "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_specialists_on_city_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_attempts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "screening_test_id", null: false
    t.json "answers"
    t.integer "score"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screening_test_id"], name: "index_test_attempts_on_screening_test_id"
    t.index ["user_id"], name: "index_test_attempts_on_user_id"
  end

  create_table "test_questions", force: :cascade do |t|
    t.integer "screening_test_id", null: false
    t.text "text"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screening_test_id"], name: "index_test_questions_on_screening_test_id"
  end

  create_table "trusted_contacts", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.string "name"
    t.string "email"
    t.boolean "share_mood"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_trusted_contacts_on_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "role", default: "curious", null: false
    t.string "access_role", default: "reader", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_tags", "articles"
  add_foreign_key "article_tags", "tags"
  add_foreign_key "articles", "users", column: "author_id"
  add_foreign_key "mood_entries", "profiles"
  add_foreign_key "profiles", "cities"
  add_foreign_key "profiles", "users"
  add_foreign_key "recommendations", "articles"
  add_foreign_key "recommendations", "test_attempts"
  add_foreign_key "specialists", "cities"
  add_foreign_key "test_attempts", "screening_tests"
  add_foreign_key "test_attempts", "users"
  add_foreign_key "test_questions", "screening_tests"
  add_foreign_key "trusted_contacts", "profiles"
end
