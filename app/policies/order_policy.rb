class OrderPolicy < ApplicationPolicy
  def show?
    user == record.user || user&.owner? # User sees own orders; owner sees all
  end

  def create?
    user.present? # Only logged-in users can create orders
  end

  def update? # For owner approving/declining
    user&.owner? # Only owners can update order status
  end

  class Scope < Scope
    def resolve
      user.owner? ? scope.all : scope.where(user_id: user.id) # Owners see all; users see own
    end
  end
end
