require 'redmine'

Redmine::Plugin.register :redmine_extra_recipients do
  name 'Redmine Extra Recipients'
  author 'Eric Davis'
  description 'Adds additional recipients to email notifications'
  url 'https://projects.littlestreamsoftware.com/projects/redmine-recipients'
  author_url 'http://www.littlestreamsoftware.com'
  version '0.1.0'

  requires_redmine :version_or_higher => '1.0.0'

  settings(:partial => 'settings/extra_recipients_settings',
           :default => {
             'recipients' => ''
           })
end
