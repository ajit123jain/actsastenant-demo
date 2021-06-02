class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  set_current_tenant_through_filter
  before_action :set_tenant

  before_action :redirect_to_subdomain

  def set_tenant 
    #find_tenant = Tenant.first
    #current_tenant is a method set by acts_as_tenant. don't override it.
    #find_tenant = Tenant.find(10)
    #find_tenant = Tenant.find(params[:id])
    #set_current_tenant(find_tenant)

    #if Tenant.any?
    #  set_current_tenant(Tenant.first)
    #else
    #  set_current_tenant(nil)
    #end

    #set_current_tenant(Tenant.second)
    #set_current_tenant(nil)

    if current_user
      if current_user.tenant.present?
        #Tenant.find(10)
        #current_tenant = Tenant.find(params[:id])
        @current_tenant_name = current_user.tenant.subdomain
        set_current_tenant(current_user.tenant)
      else
        set_current_tenant(nil)
      end
    end
  end

  def after_sign_in_path_for(resource_or_scope) 
    dashboard_index_url(subdomain: resource_or_scope.subdomain)
  end

  def after_sign_out_path_for(resource) 
    root_url(subdomain: '') 
  end

  def redirect_to_subdomain
    return if self.is_a?(DeviseController)

    if current_user.present? && request.subdomain != current_user.subdomain
      subdomain = current_user.subdomain
      host = request.host_with_port.sub! "#{request.subdomain}", subdomain

      redirect_to "http://#{host}#{request.path}"
    end # if
  end # red

  def redirect_to_app_url
    return if request.subdomain.present? && request.subdomain == 'app'

    url = app_url
    redirect_to url
  end # redirect_to_app_url


  def app_url
    subdomain = 'app' 
    if request.subdomain.present?
      host = request.host_with_port.sub! "#{request.subdomain}.", ''
    else
      host = request.host_with_port
    end # if

    "http://#{subdomain}.#{host}#{request.path}"
  end # app_url
end
