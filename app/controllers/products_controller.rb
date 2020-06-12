class ProductsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
      @products = Product.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @products =   Product.new
  end

  # GET /projects/1/edit
  # def edit
  #   project_company_id = @project.client_company_id
  #   @project_company = ClientCompany.find(project_company_id) rescue nil
  #   @client_companies = ClientCompany.all.where.not(id: project_company_id) rescue nil
  #
  #   # project_employee_id = @project.employee_id
  #   @project_employee = Employee.find(project_employee_id) rescue nil
  #   @employees = Employee.all.where.not(id: project_employee_id) rescue nil
  # end

  # POST /projects
  # POST /projects.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to products_path, notice: 'Product is successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  # def update
  #   respond_to do |format|
  #     if @project.update(project_params)
  #       format.html {redirect_to projects_path, notice: 'Project was successfully updated.'}
  #       format.json {render :show, status: :ok, location: @project}
  #     else
  #       format.html {render :edit}
  #       format.json {render json: @project.errors, status: :unprocessable_entity}
  #     end
  #   end
  # end
  #
  # # DELETE /projects/1
  # # DELETE /projects/1.json
  # def destroy
  #   begin
  #     if  @project.project_companies.present? || @project.foremen.present? ||
  #         @project.cost_codes.present? || @project.other_managers.present? || @project.budget_holders.present? ||
  #         @project.employees.present? || @project.plant_types.present?
  #       respond_to do |format|
  #         format.js
  #       end
  #     else
  #       @project.destroy
  #       @destroy = true
  #       respond_to do |format|
  #         format.js
  #       end
  #     end
  #   rescue => e
  #     redirect_to projects_path, notice: 'Project can not deleted because it is linked with its assosiative records'
  #   end
  # end


  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_project
  #   @project = Project.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:project).permit(:name, :cost, :description, :category)
    # pp[:project_status] = params[:project][:project_status].to_i
    # return pp
  end
end
