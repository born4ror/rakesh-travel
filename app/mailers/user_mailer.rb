class UserMailer < ActionMailer::Base
  default from: "technolabs <solute@technolabs.com>"

  include Mail::Utilities

  def invite_user email_user, user, project
    @user = user
    @project = project
    mail(:to => email_user,
         :subject => "Invitation to #{@project.name}")
  end
end
