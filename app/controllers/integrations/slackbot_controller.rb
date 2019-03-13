class Integrations::SlackbotController < ApplicationController
  before_filter :verify_slack_token!

  def events
    reply("I cannot search without a chapter name ¯\_(ツ)_/¯") and return unless params[:text].present?

    chapter = ::Chapter.where('lower(name) = ?', params[:text].to_s).first()
    reply("I cannot find the chapter you are looking for ¯\_(ツ)_/¯") and return if chapter.nil?

    events = ::Event.future_public_events.where(:chapter_id => chapter.id)
    reply(
      "I found #{events.count} event(s) scheduled for #{chapter.name} chapter",
      events.map { |e|
        e.name
      }
    )
  end

  private

  def verify_slack_token!
    if params[:token] != CFG_SLACK_VERIFICATION_KEY
      render :json => { :text => 'Failed to verify slack token' }
    end
  end

  def reply(text, attachments = [])
    render :json => {
      :text => text,
      :attachments => attachments.map { |s|
        { :text => s }
      }
    }
  end
end
