RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan do
    # redirect_to main_app.root_path unless current_user.role == 'admin'
  end

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    state

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Review' do
    list do
      scopes [:new_, :processed]
      field :user
      field :book
      field :title
      field :text
      field :created_at
      field :status, :state
    end

    state({
      events: {approve: 'btn-success', reject: 'btn-danger'},
      states: {unprocessed: 'label-warning', rejected: 'label-danger', approved: 'label-success'}
      # disable: [:dead] # disable some events so they are not shown.
    })
  end
end
