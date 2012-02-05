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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120205184718) do

  create_table "boletines", :force => true do |t|
    t.string   "archivo_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "titulo"
    t.text     "destinatarios"
    t.boolean  "enviado"
    t.string   "archivo_name"
  end

  create_table "cajas", :force => true do |t|
    t.string   "titulo"
    t.text     "cuerpo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clientes", :force => true do |t|
    t.string   "nombre"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fotos", :force => true do |t|
    t.string   "imagen_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imagen_width"
  end

  create_table "navegaciones", :force => true do |t|
    t.integer  "pagina_id"
    t.integer  "orden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "navegaciones", ["pagina_id"], :name => "index_navegaciones_on_pagina_id"

  create_table "paginas", :force => true do |t|
    t.string   "titulo"
    t.text     "cuerpo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "borrador"
    t.integer  "published_id"
    t.boolean  "portada",      :default => false
  end

  add_index "paginas", ["published_id"], :name => "index_paginas_on_published_id"

  create_table "sidebars", :force => true do |t|
    t.integer  "pagina_id"
    t.integer  "caja_id"
    t.integer  "orden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sidebars", ["caja_id"], :name => "index_sidebars_on_caja_id"
  add_index "sidebars", ["pagina_id"], :name => "index_sidebars_on_pagina_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id", "sluggable_type"], :name => "index_slugs_on_sluggable_id_and_sluggable_type"
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "usuarios", :force => true do |t|
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.string   "password_salt",                      :default => "", :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["tag"], :name => "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"

end
