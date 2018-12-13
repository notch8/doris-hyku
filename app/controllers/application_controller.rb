class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, prepend: true

  force_ssl if: :ssl_configured?

  helper Openseadragon::OpenseadragonHelper
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  include Hydra::Controller::ControllerBehavior

  # Adds Hyrax behaviors into the application controller
  include Hyrax::Controller

  include Hyrax::ThemedLayoutController
  with_themed_layout '1_column'

  helper_method :peek_enabled?, :current_account, :admin_host?

  before_action :require_active_account!, if: :multitenant?
  before_action :set_account_specific_connections!
  skip_after_action :discard_flash_if_xhr
  before_action :set_raven_context

  rescue_from Apartment::TenantNotFound do
    raise ActionController::RoutingError, 'Not Found'
  end

  private
    def set_raven_context
      Raven.user_context(id: session[:current_user_id]) # or anything else in session
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def peek_enabled?
      can? :peek, Hyku::Application
    end

    def require_active_account!
      return unless Settings.multitenancy.enabled
      return if devise_controller? || peek_controller?

      raise Apartment::TenantNotFound, "No tenant for #{request.host}" unless current_account.persisted?
    end

    def set_account_specific_connections!
      current_account.switch! if current_account
    end

    def multitenant?
      Settings.multitenancy.enabled
    end

    def admin_host?
      return false unless multitenant?

      Account.canonical_cname(request.host) == Account.admin_host
    end

    def current_account
      @current_account ||= Account.from_request(request)
      @current_account ||= Account.single_tenant_default
    end

    # Add context information to the lograge entries
    def append_info_to_payload(payload)
      super
      payload[:request_id] = request.uuid
      payload[:user_id] = current_user.id if current_user
      payload[:account_id] = current_account.cname if current_account
    end

    def ssl_configured?
      ActiveRecord::Type::Boolean.new.cast(Settings.ssl_configured)
    end

    def peek_controller?
      is_a? Peek::ResultsController
    end
end
