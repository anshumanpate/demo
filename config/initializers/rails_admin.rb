RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ## Popular gems integration

  # == Devise ==
  config.authenticate_with do
  warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # == CancanCan ==
  config.authorize_with :cancancan

  ## More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration




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

   
    history_index
    history_show
  end

  config.model 'User' do
    list do
      field :id
      field :email
      field :admin

      field :created_at
      field :updated_at
    end

    edit do
      field :email
      field :admin

      field :password
      field :password_confirmation
    end

    show do
      field :id
      field :email
      field :admin

      field :created_at
      field :updated_at
    end

    create do
      field :email
      field :password
      field :password_confirmation
    end

    update do
      field :email
      field :admin

      field :password
      field :password_confirmation
    end
  end


  
  config.model 'Connection' do
    list do
      field :id
      field :requester
      field :requestee
      field :status
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :requester
      field :requestee
      field :status
      field :created_at
      field :updated_at
    end

    edit do
      field :requester
      field :requestee
      field :status, :enum do
        enum do
          Connection::STATUSES
        end
      end
    end
  end

end
