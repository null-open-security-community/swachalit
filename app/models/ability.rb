class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :update, EventSession do |event_session|
      user.can_edit_event_session?(event_session)
    end

    can :manage, Event do |event|
      user.managed_chapter?(event.chapter) #&& user.managed_venue?(event.venue)
    end

    can :manage, Venue do |venue|
      user.managed_venue?(venue)
    end

    can :read, Page do |page|
      page.published?
    end

    can :manage, Page do |page|
      PageAccessPermission.can_manage?(user, page)
    end

    can :manage, Chapter do |chapter|
      user.managed_chapter?(chapter)
    end
    
  end
end
