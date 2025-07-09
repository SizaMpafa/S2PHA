class CartPolicy < ApplicationPolicy
  def show?
    user == record.user # User can only see their own cart
  end

  def update?
    user == record.user # User can only modify their own cart
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user.id) # Users see only their own cart
    end
  end
end
