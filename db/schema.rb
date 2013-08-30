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

ActiveRecord::Schema.define(:version => 20110617172313) do

  create_table "cart_packages", :force => true do |t|
    t.integer  "school_id"
    t.integer  "package_id"
    t.integer  "quantity",            :default => 1,    :null => false
    t.string   "student_first_name"
    t.string   "student_last_name"
    t.string   "student_grade"
    t.string   "student_teacher"
    t.string   "student_sport_level"
    t.string   "student_sport"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "purchase_id"
    t.boolean  "email_picture",       :default => true
  end

  create_table "cart_packages_options", :id => false, :force => true do |t|
    t.integer "cart_package_id"
    t.integer "option_id"
  end

  create_table "cart_products", :force => true do |t|
    t.integer  "product_id"
    t.string   "school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_uploads", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "line_item_id"
  end

  create_table "line_items", :force => true do |t|
    t.string   "data"
    t.integer  "price"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nav_links", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :default => 0, :null => false
  end

  create_table "option_assignments", :force => true do |t|
    t.integer  "option_type_id"
    t.integer  "package_id"
    t.integer  "school_id"
    t.datetime "begin"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "option_types", :force => true do |t|
    t.string   "title"
    t.boolean  "required",   :default => false, :null => false
    t.boolean  "multiple",   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.string   "title"
    t.integer  "option_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "orders", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.integer  "phone"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "zip_code"
    t.string   "state"
    t.integer  "price"
    t.boolean  "processed",       :default => false, :null => false
  end

  create_table "package_types", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.boolean  "sport_level",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "package_types_schools", :id => false, :force => true do |t|
    t.integer "package_type_id"
    t.integer "school_id"
  end

  create_table "packages", :force => true do |t|
    t.string   "title"
    t.integer  "package_type_id"
    t.string   "slug"
    t.integer  "minimum_quantity",   :default => 1,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "email_picture",      :default => false
    t.boolean  "purchase_id",        :default => false, :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  create_table "prices", :force => true do |t|
    t.integer  "price"
    t.integer  "school_id"
    t.datetime "begin"
    t.datetime "end"
    t.integer  "package_id"
    t.integer  "option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.float    "price",              :default => 0.0, :null => false
    t.integer  "minimum_quantity",   :default => 1,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "proof_images", :force => true do |t|
    t.integer  "proof_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "proofs", :force => true do |t|
    t.string   "student_id"
    t.string   "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "races", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "runner_id"
    t.integer  "race_id"
    t.string   "distance"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "title"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "runners", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone"
    t.string   "email"
    t.string   "gender"
    t.string   "shirt_size"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.string   "title"
    t.integer  "school_type_id"
    t.string   "slug"
    t.boolean  "teacher",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
