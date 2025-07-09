class UserPolicy < ApplicationPolicy
  def show?
    user == record || user&.owner? # User can see own profile; owner can see all
  end

  def update?
    user == record || user&.owner? # User can edit own profile; owner can edit all
  end

  class Scope < Scope
    def resolve
      user.owner? ? scope.all : scope.where(id: user.id) # Owners see all users; users see only themselves
    end
  end
end
