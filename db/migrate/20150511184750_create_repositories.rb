class CreateRepositories < ActiveRecord::Migration
  def change
    create_table "repositories", force: :cascade do |t|
      t.text     "name"
      t.text     "readme_url"
      t.datetime "pushed_at"
      t.integer  "watchers"
      t.hstore   "languages"
      t.text     "readme_text"
      t.boolean  "is_private",  default: false
    end
  end
end
