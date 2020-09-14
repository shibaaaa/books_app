# frozen_string_literal: true

class InitSchema < ActiveRecord::Migration[6.0]
  def up
    create_table "active_storage_attachments" do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.integer "record_id", null: false
      t.integer "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end
    create_table "active_storage_blobs" do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.bigint "byte_size", null: false
      t.string "checksum", null: false
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end
    create_table "books" do |t|
      t.string "title"
      t.text "memo"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "picture"
      t.integer "user_id"
      t.index ["user_id"], name: "index_books_on_user_id"
    end
    create_table "comments" do |t|
      t.text "content"
      t.string "commentable_type", null: false
      t.integer "commentable_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.integer "user_id", null: false
      t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
      t.index ["user_id"], name: "index_comments_on_user_id"
    end
    create_table "follows" do |t|
      t.integer "follower_id"
      t.integer "followed_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["followed_id"], name: "index_follows_on_followed_id"
      t.index ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
      t.index ["follower_id"], name: "index_follows_on_follower_id"
    end
    create_table "reports" do |t|
      t.string "title"
      t.text "content"
      t.integer "user_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["user_id"], name: "index_reports_on_user_id"
    end
    create_table "users" do |t|
      t.string "email", null: false
      t.string "encrypted_password", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "name"
      t.integer "postal"
      t.string "address"
      t.text "introduction"
      t.string "provider", default: "", null: false
      t.string "uid", default: "", null: false
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
      t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    end
    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
    add_foreign_key "books", "users"
    add_foreign_key "comments", "users"
    add_foreign_key "reports", "users"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
