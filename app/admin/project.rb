ActiveAdmin.register Project do

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
 
  # index action
  index do
    column :title do |project|
      link_to project.title, admin_project_path(project)
      #link_to project.title, [:admin, project]
    end
    column "Created Date", :created_at
    actions
  end
  # Filter only by title
  filter :title


  # show action
  show :title => :title do
    panel "Tasks" do
      table_for project.tasks do |t|
        t.column("Status") { |task| status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
        t.column("Title") { |task| link_to task.title, admin_task_path(task) }
        t.column("Assigned To") { |task| task.admin_user.email }
        t.column("Due Date") { |task| task.due_date? ? l(task.due_date, :format => :long) : '-' }
      end
    end
    active_admin_comments
  end
  
  
  controller do
    def permitted_params
      params.permit project: [:title]
    end
  end
end
