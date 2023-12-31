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

ActiveRecord::Schema.define(version: 2023_10_13_103130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "category_type", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_podcasts", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "podcast_id", null: false
    t.index ["category_id", "podcast_id"], name: "index_categories_podcasts_on_category_id_and_podcast_id", unique: true
    t.index ["category_id"], name: "index_categories_podcasts_on_category_id"
    t.index ["podcast_id"], name: "index_categories_podcasts_on_podcast_id"
  end

  create_table "favorite_podcasts", force: :cascade do |t|
    t.bigint "podcast_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
    t.index ["podcast_id"], name: "index_favorite_podcasts_on_podcast_id"
    t.index ["user_id"], name: "index_favorite_podcasts_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "podcast_id"
    t.string "uuid"
    t.integer "status", default: 0
    t.integer "payment_method"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["podcast_id"], name: "index_orders_on_podcast_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "podcasts", force: :cascade do |t|
    t.integer "position", default: 0
    t.decimal "price", default: "1.0"
    t.string "currency", default: "USD"
    t.string "title"
    t.string "description"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.string "audio_file_name"
    t.string "audio_content_type"
    t.bigint "audio_file_size"
    t.datetime "audio_updated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rating", default: 0
    t.boolean "top", default: false
    t.boolean "recommended", default: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "podcast_id"
    t.integer "rating_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["podcast_id"], name: "index_ratings_on_podcast_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "user_podcasts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "podcast_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["podcast_id"], name: "index_user_podcasts_on_podcast_id"
    t.index ["user_id"], name: "index_user_podcasts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "redis_key"
    t.integer "provider"
    t.string "uuid"
    t.index ["email"], name: "index_users_on_email"
  end

end
