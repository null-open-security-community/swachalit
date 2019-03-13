ActiveAdmin.register ChapterLead do
  menu :label => 'Chapter Leads', :parent => 'Chapters'

  filter :chapter
  filter :active

  index do
    column :id
    column('Chapter') {|c| link_to(c.chapter.name, admin_chapter_path(c.chapter)).html_safe }
    column('Lead') {|c| link_to(c.user.name, admin_user_path(c.user)) }
    column :active

    default_actions
  end

  form do |f|
    f.inputs "Chapter Lead" do
      f.input :chapter
      # The selected value, required during edit, everything else is fetched by select2
      f.input :user, :as => :select, :collection => [ f.object.user ].compact(), :input_html => { :class => 'need-user-autocomplete' }
      f.input :active
    end

    f.actions
  end
end
