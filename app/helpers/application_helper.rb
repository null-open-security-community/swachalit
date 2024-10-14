module ApplicationHelper
  def title(t)
    page_title(t)
  end

  def page_title(page_title)
    content_for(:title) { page_title }
  end

  def page_description(desc)
    content_for(:description) { desc }
  end

  def page_image(img_path)
    content_for(:image_url) { img_path }
  end

  def content_for_or_default(key, default)
    if content_for?(key)
      content_for(key)
    else
      default
    end
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

  def twitter_icon(url = 'http://null.community', size = '40x40')
    sm_icon_with_link('twitter', url, size)
  end

  def facebook_icon(url = 'http://null.community', size = '40x40')
    sm_icon_with_link('facebook', url, size)
  end

  def group_icon(url, size = '40x40')
    sm_icon_with_link('group', url, size)
  end

  def safe_url(s)
    s = s.to_s
    return '#' if s.empty?

    s = s.gsub(/(\r|\n|\s)/, '')

    return '#' if s =~ /\Ajavascript/i
    return '#' if s =~ /\Achrome/i
    return '#' if s =~ /\Aabout/i
    return "http://#{s}" if s !~ /\Ahttp/i   # Force protocol

    return s
  end

  def user_attendance_brief(user)
    t = user.event_registrations.absent.count > 0 ? 'danger' : 'info'
    ("<span class='label label-#{t}'>A:%d/T:%d</span>" %
      [user.event_registrations.absent.count, user.event_registrations.count]).html_safe
  end

  def exif_warning
    content_tag(:small) do
      %q|The file will be uploaded and stored "as is" without processing.
      Ensure EXIF data is not exposing sensitve information.|
    end
  end

end
