class Ability
  include CanCan::Ability

  def initialize(user)

    if user.is_owner? || user.is_general_manager?
      can :manage, :all
    end

    if user.is_cashier?
      can :manage, [Sale , Customer]
      can :manage, LineItem
      can :manage, Payment
    end

    if user.is_store_manager?
      can :manage, [Sale , User , Expense , Item , ItemCategory , Customer]
      can :manage, LineItem
      can :manage, Payment
    end

    if user.is_warehouse_manager?
      can :manage, [Customer]
    end

    if user.is_inventory_manager? || user.is_warehouse_manager?
      can :manage, [Item , ItemCategory , Expense]
    end

    # if user.can_update_configuration == true
    #     can :manage, Company
    # elsif user.can_update_users == true
    #     can :manage, User
    # elsif user.can_view_reports == true
    #     # can :manage, Report
    #
    # elsif user.can_update_sale_discount == true
    #
    # elsif user.can_remove_sales == true
    #     can :manage, Sale
    # end



    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
