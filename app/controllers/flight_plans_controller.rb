class FlightPlansController < ApplicationController
  before_action :set_flight_plan, only: [:show, :edit, :update, :destroy, :run, :submit]
  DEFAULT_EMAIL = 'ragnarcom@googlemail.com'

  # GET /flight_plans
  # GET /flight_plans.json
  def index
    @flight_plans = FlightPlan.order(id: :desc)
    @email = DEFAULT_EMAIL
  end

  # POST /flight_plans/delete_all
  def delete_all
    FlightPlan.destroy_all
    redirect_to flight_plans_path
  end

  # POST /flight_plans/download
  def download
    email = params.require([:email]).first
    raise "Bad email address" unless email.match URI::MailTo::EMAIL_REGEXP
    FlightPlanDownloader.new(Api.new(Client.new(email: email))).download
    redirect_to flight_plans_path
  end

  # POST /flight_plans/1/run
  def run
    FlightPlanRunner.new(@flight_plan).run
    redirect_to flight_plans_path
  end

  def submit
    unless @flight_plan.final_x_location && @flight_plan.final_y_location
      raise "missing x or y final locations #{@flight_plan}"
    end
    email = params.require([:email]).first
    raise "Bad email address" unless email.match URI::MailTo::EMAIL_REGEXP
    @api_response = Api.new(Client.new(email: email))
                      .location(@flight_plan.final_x_location,
                                @flight_plan.final_y_location)
  end

  # GET /flight_plans/1
  # GET /flight_plans/1.json
  def show
  end

  # GET /flight_plans/new
  def new
    @flight_plan = FlightPlan.new
  end

  # GET /flight_plans/1/edit
  def edit
  end

  # POST /flight_plans
  # POST /flight_plans.json
  def create
    @flight_plan = FlightPlan.new(flight_plan_params)

    respond_to do |format|
      if @flight_plan.save
        format.html { redirect_to @flight_plan, notice: 'Flight plan was successfully created.' }
        format.json { render :show, status: :created, location: @flight_plan }
      else
        format.html { render :new }
        format.json { render json: @flight_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flight_plans/1
  # PATCH/PUT /flight_plans/1.json
  def update
    respond_to do |format|
      if @flight_plan.update(flight_plan_params)
        format.html { redirect_to @flight_plan, notice: 'Flight plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @flight_plan }
      else
        format.html { render :edit }
        format.json { render json: @flight_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flight_plans/1
  # DELETE /flight_plans/1.json
  def destroy
    @flight_plan.destroy
    respond_to do |format|
      format.html { redirect_to flight_plans_url, notice: 'Flight plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight_plan
      @flight_plan = FlightPlan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flight_plan_params
      params.require(:flight_plan).permit(:final_x_location, :final_y_location)
    end
end
