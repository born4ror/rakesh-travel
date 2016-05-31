class VisitorsController < ApplicationController

	def index
		if current_user
      @user_projects = current_user.projects
      @project = Project.new
    end
	end
end
