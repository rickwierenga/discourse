# frozen_string_literal: true

class DropChatMentionNotificationsOldIdColumn < ActiveRecord::Migration[7.1]
  def up
    Migration::SafeMigrate.disable!

    if column_exists?(:chat_mention_notifications, :old_notification_id)
      Migration::ColumnDropper.drop_readonly(:chat_mention_notifications, :old_notification_id)
      remove_column :chat_mention_notifications, :old_notification_id
    end
  ensure
    Migration::SafeMigrate.enable!
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
