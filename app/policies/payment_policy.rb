class PaymentPolicy < ApplicationPolicy
  def show?
    user == record.order.user || user&.owner? # User sees own payments; owner sees all
  end

  def create?
    user == record.order.user # Only the order’s user can create a payment
  end

  class Scope < Scope
    def resolve
      user.owner? ? scope.all : scope.joins(:order).where(orders: { user_id: user.id })
    end
  end
end
