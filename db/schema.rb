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

ActiveRecord::Schema[7.0].define(version: 2022_06_19_010056) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.text "introduction"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_candidates_on_account_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.bigint "professor_id", null: false
    t.bigint "candidate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_chatrooms_on_candidate_id"
    t.index ["professor_id"], name: "index_chatrooms_on_professor_id"
  end

  create_table "dreaming_faculties", force: :cascade do |t|
    t.bigint "faculty_id", null: false
    t.bigint "candidate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_dreaming_faculties_on_candidate_id"
    t.index ["faculty_id"], name: "index_dreaming_faculties_on_faculty_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name"
    t.bigint "university_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["university_id"], name: "index_faculties_on_university_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "account_id", null: false
    t.bigint "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_messages_on_account_id"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professor_faculities", force: :cascade do |t|
    t.bigint "professor_id", null: false
    t.bigint "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_professor_faculities_on_faculty_id"
    t.index ["professor_id"], name: "index_professor_faculities_on_professor_id"
  end

  create_table "professors", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_professors_on_account_id"
  end

  create_table "recruitments", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "professor_id", null: false
    t.bigint "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_recruitments_on_faculty_id"
    t.index ["professor_id"], name: "index_recruitments_on_professor_id"
  end

  create_table "researches", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "professor_id", null: false
    t.bigint "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_researches_on_faculty_id"
    t.index ["professor_id"], name: "index_researches_on_professor_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction"
    t.bigint "prefecture_id", null: false
    t.text "url"
    t.text "note"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_universities_on_prefecture_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "candidates", "accounts"
  add_foreign_key "chatrooms", "candidates"
  add_foreign_key "chatrooms", "professors"
  add_foreign_key "dreaming_faculties", "candidates"
  add_foreign_key "dreaming_faculties", "faculties"
  add_foreign_key "faculties", "universities"
  add_foreign_key "messages", "accounts"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "professor_faculities", "faculties"
  add_foreign_key "professor_faculities", "professors"
  add_foreign_key "professors", "accounts"
  add_foreign_key "recruitments", "faculties"
  add_foreign_key "recruitments", "professors"
  add_foreign_key "researches", "faculties"
  add_foreign_key "researches", "professors"
  add_foreign_key "universities", "prefectures"
end
