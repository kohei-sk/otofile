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

ActiveRecord::Schema.define(version: 2020_06_28_115136) do

  create_table "comments", force: :cascade do |t|
    t.string "c_uid"
    t.text "comment"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "follows", force: :cascade do |t|
    t.string "u_id"
    t.string "f_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "profile_id"
    t.string "history"
    t.string "year"
    t.string "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_histories_on_profile_id"
  end

  create_table "likes", force: :cascade do |t|
    t.string "l_pid"
    t.string "l_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "post_id"
    t.index ["post_id"], name: "index_likes_on_post_id"
  end

  create_table "onemessages", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "onemessage_uid"
    t.integer "user_id"
    t.index ["user_id"], name: "index_onemessages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "comment"
    t.string "p_userid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "img"
    t.string "ytid"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "trendartist"
    t.text "trendsong"
    t.string "fvcate"
    t.text "fvartist"
    t.text "fvsong"
    t.string "fvmv"
    t.text "myband"
    t.string "h_year1"
    t.string "h_year2"
    t.string "h_year3"
    t.string "h_year4"
    t.string "h_year5"
    t.text "h_content1"
    t.text "h_content2"
    t.text "h_content3"
    t.text "h_content4"
    t.text "h_content5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_uid"
    t.text "free_area"
    t.text "fes_sche"
    t.text "fes_his"
    t.text "fav_playlist"
    t.string "history"
    t.integer "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.string "r_uid"
    t.text "reply"
    t.integer "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_replies_on_comment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "userid"
    t.string "userimg"
    t.string "sns_t"
    t.string "sns_f"
    t.string "sns_i"
    t.string "sns_l"
    t.string "userlink"
    t.string "hdrimg"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
