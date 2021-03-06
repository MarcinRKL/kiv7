class Api::NamespaceController < ApplicationController
  rescue_from ActiveModel::MassAssignmentSecurity::Error do |error|
    render :json => {:error => "mass_assignment", :message => "The record had fields that should not have been defined."}, :status => 422 and return
  end
  
  rescue_from ActiveRecord::RecordNotUnique do |error|
    render :json => {:error => "record_not_unique", :message => "The record did not have a unique field where required."}, :status => 422 and return
  end
  
  protected
  
  def check_authentication
    unless warden.authenticated?
      render :json => {:error => "unauthorized", :message => "You have to login before you can access your task list."}, :status => 401 and return
    end
  end
end