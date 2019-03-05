class Ability
  include Hydra::Ability
  include Hyrax::Ability

  self.ability_logic += %i[
    everyone_can_create_curation_concerns
    group_permissions
    superadmin_permissions
  ]

  # Define any customized permissions here.
  def custom_permissions
    can [:create], Account
  end

  def admin_permissions
    return unless admin?
    return if superadmin?

    super
    can [:manage], [Site, Role, User]

    can [:read, :update], Account do |account|
      account == Site.account
    end
  end

  def group_permissions
    return unless admin?

    can :manage, Hyku::Group
  end

  def superadmin_permissions
    return unless superadmin?

    can :manage, :all
  end

  def superadmin?
    current_user.has_role? :superadmin
  end

  # Override this to remove abliity for public files to be downloaded
  # by non-users
  def test_download(id)
    Rails.logger.debug("[CANCAN] DORIS Checking download permissions for user: #{current_user.user_key} with groups: #{user_groups.inspect}")
    return false if user_groups == ["public"]
    group_intersection = user_groups & download_groups(id)
    !group_intersection.empty? || download_users(id).include?(current_user.user_key)
  end
end
