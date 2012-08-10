class AddAnswersToRawUrlAndRawBody < ActiveRecord::Migration
  def change
    add_column :answers, :raw_url, :string
    add_column :answers, :raw_body, :text
  end
end
