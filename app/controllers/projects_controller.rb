class ProjectsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project, only: [:edit, :update, :destroy]
  load_resource only: [:edit, :update, :destroy]
  # GET /projects
  # GET /projects.json
  

  # GET /projects/new
  def new
    @project = Project.new
    @project.build_image
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to root_path, notice: 'Project was successfully created.'}
        format.js {}
      else
        @faild = true
        format.js { }
      end
    end
  end

  def update_style
    @project = Project.find(params[:project_id])
    @project.update(
      name_color: params[:name_color],
      name_font_size: params[:name_font_size],
      date_color: params[:date_color],
      date_font_size: params[:date_font_size],
      description_color: params[:description_color],
      description_text_color: params[:description_text_color]
    )

    respond_to do |format|
      format.js {}
    end
  end
  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :submission_date, :description, :user_id, :avatar)
    end
end
