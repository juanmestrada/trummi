# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_29_140041) do

  create_table "blocks", force: :cascade do |t|
    t.integer "blocker_id"
    t.integer "blockee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["blockee_id"], name: "index_blocks_on_blockee_id"
    t.index ["blocker_id", "blockee_id"], name: "index_blocks_on_blocker_id_and_blockee_id", unique: true
    t.index ["blocker_id"], name: "index_blocks_on_blocker_id"
  end

  create_table "clapping_reactions", force: :cascade do |t|
    t.boolean "clapping_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "profile_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "author_id"
    t.integer "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "author_destroy", default: false
    t.boolean "receiver_destroy", default: false
    t.index ["author_id", "receiver_id"], name: "index_conversations_on_author_id_and_receiver_id", unique: true
    t.index ["author_id"], name: "index_conversations_on_author_id"
    t.index ["receiver_id"], name: "index_conversations_on_receiver_id"
  end

  create_table "crying2_reactions", force: :cascade do |t|
    t.boolean "crying2_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "crying_reactions", force: :cascade do |t|
    t.boolean "crying_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dafuq_reactions", force: :cascade do |t|
    t.boolean "dafuq_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "disapproval_reactions", force: :cascade do |t|
    t.boolean "disapproval_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "entertained_reactions", force: :cascade do |t|
    t.boolean "entertained_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "excited_reactions", force: :cascade do |t|
    t.boolean "excited_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fightme_reactions", force: :cascade do |t|
    t.boolean "fightme_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "laughing_reactions", force: :cascade do |t|
    t.boolean "laughing_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.boolean "like"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mad_reactions", force: :cascade do |t|
    t.boolean "mad_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "personal_messages", force: :cascade do |t|
    t.text "body"
    t.integer "conversation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "profile_id"
    t.boolean "read", default: false
    t.boolean "author_destroy", default: false
    t.boolean "receiver_destroy", default: false
    t.index ["conversation_id"], name: "index_personal_messages_on_conversation_id"
    t.index ["profile_id"], name: "index_personal_messages_on_profile_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "profile_id"
    t.string "image"
  end

  create_table "profile_keywords", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "keyword_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "headline"
    t.text "about"
    t.text "searchingfor"
    t.string "ethnicity"
    t.string "relationship"
    t.string "sexuality"
    t.string "height"
    t.string "bodytype"
    t.string "eyecolor"
    t.string "haircolor"
    t.string "living"
    t.string "kids"
    t.string "smoking"
    t.string "drinking"
    t.string "language"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image1"
    t.string "image2"
    t.string "image3"
    t.string "image4"
    t.boolean "verified", default: false
    t.boolean "private", default: false
    t.boolean "private_tags", default: false
    t.string "location"
    t.string "religion"
    t.string "education"
    t.boolean "isdisabled", default: false
    t.string "username"
    t.integer "age"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "proud_reactions", force: :cascade do |t|
    t.boolean "proud_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "tea_reactions", force: :cascade do |t|
    t.boolean "tea_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tellmemore_reactions", force: :cascade do |t|
    t.boolean "tellmemore_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "thatsracist_reactions", force: :cascade do |t|
    t.boolean "thatsracist_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "thinkaboutit_reactions", force: :cascade do |t|
    t.boolean "thinkaboutit_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "unsure_reactions", force: :cascade do |t|
    t.boolean "unsure_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_tags", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "tag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.date "dob"
    t.boolean "isunderage", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "what_reactions", force: :cascade do |t|
    t.boolean "what_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wtf_reactions", force: :cascade do |t|
    t.boolean "wtf_reaction"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "personal_messages", "conversations"
  add_foreign_key "personal_messages", "profiles"
  add_foreign_key "profiles", "users"
end
