require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineExtraRecipients::Patches::IssueTest < ActionController::TestCase

  context "Issue" do
    context "#recpients" do
      setup do
        configure_plugin
      end

      context "for a public project" do
        should "include email addresses from the plugin" do
          @project = Project.generate!(:is_public => true)
          @issue = Issue.generate_for_project!(@project)

          assert @issue.recipients.include?('test@example.com')
          assert @issue.recipients.include?('test2@example.com')
          assert @issue.recipients.include?('test3@example.com')
        end
      end

      context "for a private project" do
        setup do
          @project = Project.generate!(:is_public => false)
          @issue = Issue.generate_for_project!(@project)
        end
        
        context "with include_private" do
          setup do
            reconfigure_plugin('private_project_visibility' => 'include_private')
          end

          should "include email addresses from the plugin" do
            assert @issue.recipients.include?('test@example.com')
            assert @issue.recipients.include?('test2@example.com')
            assert @issue.recipients.include?('test3@example.com')
          end
        end

        context "with exclude_private" do
          setup do
            reconfigure_plugin('private_project_visibility' => 'exclude_private')
          end

          should "include not email addresses from the plugin" do
            assert !@issue.recipients.include?('test@example.com')
            assert !@issue.recipients.include?('test2@example.com')
            assert !@issue.recipients.include?('test3@example.com')
          end
        end

      end
    end
    
  end
end
