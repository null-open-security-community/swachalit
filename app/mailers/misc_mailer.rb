class MiscMailer < ActionMailer::Base
  default :from => proc { CFG_MAILER_DEFAULT_FROM }

  def session_request_mail(target, session_request)
    @session_request = session_request
    mail(:to => target, :subject => "[Notification] New Session Request ##{session_request.id}")
  end

  def session_proposal_mail(target, session_proposal)
    @session_proposal = session_proposal
    mail(:to => target, :subject => "[Notification] New Session Proposal ##{session_proposal.id}")
  end

end
