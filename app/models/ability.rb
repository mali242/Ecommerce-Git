class Ability
  include CanCan::Ability

  def initialize(user)
    # If no one is logged in, user will be nil.
    # We don't want errors when checking email, so we use `&.` (safe navigation).
    user ||= User.new

    # 👇 Everyone (guests + logged-in users) can read products
    can :read, Product

    # 👇 Only this specific email can create, update, or destroy products
    if user.present? && user.email == "muhammadali.2420844@gmail.com"
      can :manage, Product   # :manage = create, read, update, destroy
    end
  end
end
