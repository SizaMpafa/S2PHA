class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user&.owner?
  end

  def create?
    new?
  end

  def edit?
    user&.owner?
  end

  def update?
    edit?
  end

  def destroy?
    user&.owner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
