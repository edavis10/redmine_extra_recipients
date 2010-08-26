require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineExtraRecipients::Patches::IssueTest < ActionController::TestCase

  context "Issue" do
    context "#recpients" do
      should "include email addresses from the plugin" do
        configure_plugin
        @project = Project.generate!
        @issue = Issue.generate_for_project!(@project)

        assert @issue.recipients.include?('test@example.com')
        assert @issue.recipients.include?('test2@example.com')
        assert @issue.recipients.include?('test3@example.com')
      end
    end
  end
  
end
