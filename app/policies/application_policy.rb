class ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize user, scope
        @user = user
        @scope = scope
    end

    def resolve
        scope
    end

    def system_admin?   ; user.present? && user.role == 0     ; end
    def system_manager? ; user.present? && user.role == 100   ; end
    def staff?          ; user.present? && user.role == 200   ; end
    def assistant?      ; user.present? && user.role == 300   ; end
    def anonymous?      ; user.nil?                           ; end
  end

  attr_reader :user, :record

  def initialize user, record
    # raise Pundit::NotAuthorizedError, "Debe estar logueado." unless user
    # raise Pundit::NotAuthorizedError, "Tu cuenta está inactiva." unless user.active?

    @user = user
    @record = record
  end

  # Roles
  def system_admin?   ; user.present? && user.role == 0     ; end
  def system_manager? ; user.present? && user.role == 100   ; end
  def staff?          ; user.present? && user.role == 200   ; end
  def assistant?      ; user.present? && user.role == 300   ; end
  def anonymous?      ; user.nil?                           ; end

  # Actions
  def index?          ; true                                  ; end
  def show?           ; true                                 ; end
  def create?         ; true                                 ; end
  def new?            ; create?                               ; end
  def update?         ; true                                 ; end
  def edit?           ; update?                               ; end
  def destroy?        ; true                                 ; end
end
