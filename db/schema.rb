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

ActiveRecord::Schema.define(version: 2019_10_08_225526) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "name", limit: 200
    t.string "email", limit: 200
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "student_id"
    t.string "ISBN"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "ISBN"
    t.string "title", limit: 200
    t.string "author", limit: 70
    t.string "language", limit: 20
    t.string "published", limit: 4
    t.string "edition", limit: 4
    t.string "library_id", limit: 10
    t.string "avatar", limit: 500
    t.string "subject", limit: 100
    t.string "summary", limit: 1000
    t.string "specialcollection"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "copies", limit: 6
    t.index ["ISBN"], name: "index_books_on_ISBN", unique: true
  end

  create_table "holds", force: :cascade do |t|
    t.integer "student_id"
    t.string "ISBN"
    t.string "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "librarians", primary_key: "librarian_id", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "is_valid", default: "requested"
    t.index ["email"], name: "index_librarians_on_email", unique: true
  end

  create_table "libraries", primary_key: "library_id", force: :cascade do |t|
    t.string "name", limit: 200
    t.string "university_id", limit: 100
    t.string "location", limit: 300
    t.string "max_days", limit: 10
    t.string "fines", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "educational_level"
    t.string "university_id"
    t.string "maximum_book_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_students_on_email", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "student_id"
    t.string "ISBN"
    t.string "bookname"
    t.datetime "checkout_date"
    t.datetime "expected_date"
    t.datetime "return_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "library_id"
  end

  create_table "universities", primary_key: "university_id", force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_universities_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_valid"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
