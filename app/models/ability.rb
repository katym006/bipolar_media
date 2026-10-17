# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Article, published_at: ..Time.current
    can :read, ScreeningTest
    can :read, Specialist

    return unless user.present?

    if user.access_role_author?
      can :create, Article
      can :update, Article, author_id: user.id
    end

    if user.access_role_editor?
      can :create, Article
      can :update, Article
      can :destroy, Article
    end

    if user.access_role_admin?
      can :manage, Article
      can :manage, User
      can :manage, ScreeningTest
      can :manage, Specialist
    end

    can :manage, MoodEntry, profile: { user_id: user.id }
  end
end
