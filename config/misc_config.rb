CFG_DEVISE_SENDER_EMAIL = ENV["DEVISE_SENDER_MAIL"] || 'no-reply-swachalit@null.co.in'
CFG_MAILER_DEFAULT_FROM = ENV["MAILER_DEFAULT_FROM"] || 'null Swachalit <no-reply-swachalit@null.co.in>'

CFG_IFTTT_SENDER_EMAIL = ENV["IFTTT_SENDER_EMAIL"] || "info@null.co.in"


CFG_NOTIFICATION_ANNOUNCEMENT_SENDER_ADDRESSES = 'null Swachalit <info@null.co.in>'
CFG_NOTIFICATION_ANNOUNCEMENT_DEFAULT_ADDRESSES = [
  'null-co-in@googlegroups.com'
]

CFG_EXCEPTION_NOTIFICATION_RECEIVERS = [
  'abhisek@null.co.in'
]

CFG_SECURITY_CONTACT_EMAIL = 'security@null.co.in'

CFG_NOTIFICATION_ADMIN_EVENT_CREATE = [
  'aka@null.co.in',
  'abhisek@null.co.in',
  'anant@null.co.in'
]

CFG_SENTRY_DSN = ENV["SENTRY_DSN"]
CFG_SENTRY_ENABLED = !CFG_SENTRY_DSN.to_s.empty?

CFG_APP_TITLE = 'null: The Open Security Community'
CFG_APP_DESCRIPTION = "null is India's largest open security community"
CFG_APP_DEFAULT_PAGE_IMAGE = 'null-blog-banner_white.png'   ## Image must exists in /assets/images
CFG_APP_TWITTER_IMAGE = 'null-logo.jpg'

CFG_VOLUNTEER_FORM_URL = 'https://docs.google.com/forms/d/1xKyzxbrsmTwlvcBZDF1oUaoGI5Hekw9VKZu1d4gz9lU/viewform?edit_requested=true'
CFG_GOOGLE_GROUPS_URL = 'https://groups.google.com/forum/#!forum/null-co-in'
