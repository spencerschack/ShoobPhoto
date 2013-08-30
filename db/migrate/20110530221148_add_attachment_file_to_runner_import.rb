class AddAttachmentFileToRunnerImport < ActiveRecord::Migration
  def self.up
    add_column :runner_imports, :file_file_name, :string
    add_column :runner_imports, :file_content_type, :string
    add_column :runner_imports, :file_file_size, :integer
    add_column :runner_imports, :file_updated_at, :datetime
  end

  def self.down
    remove_column :runner_imports, :file_file_name
    remove_column :runner_imports, :file_content_type
    remove_column :runner_imports, :file_file_size
    remove_column :runner_imports, :file_updated_at
  end
end
