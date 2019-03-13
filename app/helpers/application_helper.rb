module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def resource_error_messages!(resource)
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <h4>#{sentence}</h4>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def markdown_html(text)
    options = {}
    options[:fenced_code_blocks] = true
    options[:hard_wrap] = true

    r = Redcarpet::Render::HTML.new(options)
    md = Redcarpet::Markdown.new(r)
    md.render(text.to_s).html_safe
  end

  def safe_markdown_html(text, opts = {})
    s_options = {
      :filter_html => true,
      :hard_wrap => true,
      :no_images => true,
      :no_styles => true,
      :fenced_code_blocks => true,
      :link_attributes => { :target => '_blank' },
      :safe_links_only => true
    }.merge(opts)

    r = Redcarpet::Render::HTML.new(s_options)
    md =  Redcarpet::Markdown.new(r)
    md.render(text.to_s).html_safe
  end

  def sm_icon_with_link(icon, link, size = '40x40')
    link_to(link, :target => '_blank') do
      image_tag("sm_icons/#{icon}.png", :size => size)
    end
  end

  def twitter_icon(url = 'http://www.null.co.in', size = '40x40')
    sm_icon_with_link('twitter', url, size)
  end

  def facebook_icon(url = 'http://www.null.co.in', size = '40x40')
    sm_icon_with_link('facebook', url, size)
  end

  def group_icon(url, size = '40x40')
    sm_icon_with_link('group', url, size)
  end

  def safe_url(s)
    s = s.to_s
    return '#' if s.empty?

    return '' if s =~ /^javascript/i
    return '' if s =~ /^chrome/i
    return '' if s =~ /^about/i
    return "http://#{s}" if s !~ /^http/i   # Force protocol
    
    return s
  end

  def user_attendance_brief(user)
    t = user.event_registrations.absent.count > 0 ? 'danger' : 'info'
    ("<span class='label label-#{t}'>A:%d/T:%d</span>" % 
      [user.event_registrations.absent.count, user.event_registrations.count]).html_safe
  end

end
