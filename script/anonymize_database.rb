print "This script will anonymize #{User.count} user records, continue? (yes/no): "
exit unless $stdin.gets.to_s =~ /yes/i

an_default_password = "nulldev123"
an_email_idx = 0

User.all.each do |user|
  begin
    puts "Updating records for user[#{user.id}] #{user.email} ..."
    user.password = user.password_confirmation = an_default_password
    user.homepage = user.twitter_handle = user.about_me = user.facebook_profile = ""
    user.github_profile = user.linkedin_profile = user.avatar = user.handle = ""
    user.name = "Anon User #{an_email_idx}"
    user.save!

    # Force update email id
    user.update_column(:email, "anon#{an_email_idx}@localhost.local.net")
  rescue => e
    $stderr.puts "Error: #{e.message}"
  ensure
    an_email_idx += 1
  end
end

AdminUser.all.each do |user|
  puts "Updating password for admin user: #{user.email}"
  user.password = user.password_confirmation = "adminpass123"
  user.save!
end

