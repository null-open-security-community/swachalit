class IftttMailer < ActionMailer::Base
  default from: proc { CFG_IFTTT_SENDER_EMAIL }

  def twitter_status_update(msg)
    mail(:to => 'trigger@recipe.ifttt.com', :subject => '#TwitterStatusUpdate', :body => msg)
  end

end
