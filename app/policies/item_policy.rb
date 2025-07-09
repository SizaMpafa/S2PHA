# app/policies/item_policy.rb
class ItemPolicy < ApplicationPolicy
  attr_reader :user, :item

  def initialize(user, item)
    @user = user
    @item = item
  end

  def index?
    true # Anyone can view the list of items
  end

  def show?
    true # Anyone can view a single item
  end

  def new?
    user&.owner? # Only owners can create new items
  end

  def create?
    new? # Same as new?
  end

  def edit?
    user&.owner? # Only owners can edit items
  end

  def update?
    edit? # Same as edit?
  end

  def destroy?
    user&.owner? # Only owners can delete items
  end

  class Scope < Scope
    def resolve
      scope.all # All items are visible to everyone for browsing
    end
  end
end
