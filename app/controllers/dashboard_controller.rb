class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize :dashboard

Rails.logger.info "\n\n\n!!!!!!!!!!!!!!!!!!!!! @volunteers !!!!!!!!!!!!!!!!!!!!!!!!\n\n\n"
    # Return all active/inactive volunteers, inactive will be filtered by default
    @volunteers = policy_scope(
      User.includes(:case_assignments, :casa_cases, versions: [:item])
          .where(role: %w[inactive volunteer])
    ).decorate

Rails.logger.info "\n\n\n!!!!!!!!!!!!!!!!!!!!! @casa_cases !!!!!!!!!!!!!!!!!!!!!!!!\n\n\n"
    @casa_cases = policy_scope(CasaCase.includes(:case_assignments, :volunteers).all)

Rails.logger.info "\n\n\n!!!!!!!!!!!!!!!!!!!!!! @case_contacts !!!!!!!!!!!!!!!!!!!!!!!\n\n\n"
    @case_contacts = policy_scope(
      CaseContact.all
    ).order(occurred_at: :desc).decorate

Rails.logger.info "\n\n\n!!!!!!!!!!!!!!!!!!!! @supervisors !!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n"
    @supervisors = policy_scope(User.eager_load(:casa_cases).where(role: %w[supervisor]))
  end
end
