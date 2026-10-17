
# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, Article, published_at: ..Time.current

    return unless user.present?

    can :read, Article, published_at: ..Time.current

    if user.access_role_reader?

    end

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
    end

 
    can :manage, MoodEntry, profile: { user_id: user.id }
  end
end

