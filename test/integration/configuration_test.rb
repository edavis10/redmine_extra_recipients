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
    click_button "Apply"
    assert_response :success

    # field populated
    assert_select "textarea#settings_recipients", :text => /example.com/

    recipients = Setting['plugin_redmine_extra_recipients']['recipients']
    assert recipients
    assert recipients.include?('test@example.com')
    assert recipients.include?('test2@example.com')
    assert recipients.include?('test3@example.com')
  end
  
end
