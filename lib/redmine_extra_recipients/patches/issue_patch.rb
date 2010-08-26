module RedmineExtraRecipients
  module Patches
    module IssuePatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable

          alias_method_chain :recipients, :extra_recipients
        end
      end

      module ClassMethods
      end

      module InstanceMethods
        def recipients_with_extra_recipients
          notified = recipients_without_extra_recipients
          if Setting['plugin_redmine_extra_recipients'].present? &&
              Setting['plugin_redmine_extra_recipients']['recipients'].present?

            extra_recipients = Setting['plugin_redmine_extra_recipients']['recipients']
            extra_recipients.split(/[,\n]/).each do |recipient|
              notified << recipient.strip
            end
          end
          
          notified
        end
      end
    end
  end
end
