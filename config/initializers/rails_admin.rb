RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan


  config.excluded_models = ["Ckeditor::Asset", "Ckeditor::Picture","Ckeditor::AttachmentFile","Identity"]

  config.model Contest do
    list do
      exclude_fields :c_at, :_id
    end
    edit do
      field :cname, :string
      field :ccode, :string do
        visible do
          bindings[:view]._current_user.has_role? :admin
        end
      end
      field :problems
      field :details, :ck_editor
      field :announcements
      field :start_time do
        visible do
          bindings[:view]._current_user.has_role? :admin
        end
      end
      field :end_time do
        visible do
          bindings[:view]._current_user.has_role? :admin
        end
      end
      field :state
      field :setter
      field :users
      field :details, :ck_editor
    end
  end
    config.model Problem do
      list do
        exclude_fields :c_at, :_id
      end
      edit do
        field :pcode, :string
        field :pname, :string
        field :statement, :ck_editor
        field :state
        field :time_limit
        field :memory_limit
        field :source_limit
        field :difficulty, :string
        field :submissions_count do
          visible do
            bindings[:view]._current_user.has_role? :admin
          end
        end
        field :max_score
        field :contest
        field :submissions
        field :test_cases
        field :languages
        field :setter
      end
    end

  config.model 'Ranklist' do
    list do
      exclude_fields :c_at, :_id
    end
    edit do
      field :contest
    end
  end

  config.model 'Setter' do
    list do
      exclude_fields :c_at, :_id
    end
    edit do
      field :user
      field :contests
      field :problems
    end
  end

  config.model 'Submission' do
    list do
      exclude_fields :_id, :job_id, :c_at
      end
    edit do
      field :status_code, :string
      field :user_source_code, :code_mirror
      field :submission_time
      field :error_desc, :string
      field :time_taken
      field :memory_taken
      field :user
      field :problem
      field :language
    end
  end

  config.model 'TestCase' do
    list do
      exclude_fields :_id
    end
    edit do
      exclude_fields :_id
    end
  end

  config.model 'Announcement' do
    list do
      exclude_fields :c_at, :_id
    end
    edit do
      exclude_fields :c_at, :_id
    end
  end


  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
