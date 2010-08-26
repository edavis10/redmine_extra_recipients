require 'test_helper'

class ConfigurationTest < ActionController::IntegrationTest
  setup do
    @user = User.generate_for_logging_in('user','password', :admin => true)
  end

  should "allow configuring the global recipients list" do
    login_as('user','password')

    visit_admin_panel

    click_link 'Plugins'
    assert_response :success
    assert_equal "/admin/plugins", current_path
    
    click_link 'Configure'
    assert_response :success

    fill_in "Recipients", :with => "test@example.com, test2@example.com\ntest3@example.com"
    choose "Include extra recipients in private projects"
    click_button "Apply"
    assert_response :success

    # field populated
    assert_select "textarea#settings_recipients", :text => /example.com/

    settings = Setting['plugin_redmine_extra_recipients']
    recipients = settings['recipients']
    assert recipients
    assert recipients.include?('test@example.com')
    assert recipients.include?('test2@example.com')
    assert recipients.include?('test3@example.com')

    assert_equal "include_private", settings['private_project_visibility']
  end
  
end
