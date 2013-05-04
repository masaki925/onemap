class PlandaysController < ApplicationController
  # GET /plandays/1
  # GET /plandays/1.json
  def show
    @planday = Planday.find(params[:id])
    @spots   = @planday.spots.where("planday_spots.position > 0").order('planday_spots.position ASC')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @planday }
    end
  end

  # GET /plandays/new
  # GET /plandays/new.json
  def new
    @plan = Plan.find(params[:plan_id])
    @planday = Planday.new
    @city = City.where(name: params[:city]).first if params[:city]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @planday }
    end
  end

  # GET /plandays/1/edit
  def edit
    @planday = Planday.find(params[:id])
    @plan    = @planday.plan
    @planday_spots = @planday.planday_spots.where("position > 0").order(:position)
  end

  # POST /plandays
  # POST /plandays.json
  def create
    @plan    = Plan.find(params[:plan_id])
    @planday = Planday.new(params[:planday])
    @planday.plan = @plan
    @planday.day  = @plan.plandays.size + 1

    respond_to do |format|
      if @planday.save
        format.html { redirect_to @planday, notice: 'Planday was successfully created.' }
        format.json { render json: @planday, status: :created, location: @planday }
      else
        format.html { render action: "new" }
        format.json { render json: @planday.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plandays/1
  # PUT /plandays/1.json
  def update
    @planday = Planday.find(params[:id])

    begin
      ActiveRecord::Base.transaction do
        @planday.clear_spot_positions

        if @planday.update_attributes(params[:planday])
          respond_to do |format|
            format.html { redirect_to @planday, notice: 'Planday was successfully updated.' }
            format.json { head :no_content }
          end
        end
      end
    rescue => ex
      @plan          = @planday.plan
      @planday_spots = @planday.planday_spots.where("position > 0").order(:position)

      respond_to do |format|
        format.html { redirect_to edit_planday_path(@planday), notice: "we're sorry but something wrong. please contact to administrator." }
        format.json { render json: @planday.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plandays/1
  # DELETE /plandays/1.json
  def destroy
    @planday = Planday.find(params[:id])
    @planday.destroy

    respond_to do |format|
      format.html { redirect_to plandays_url }
      format.json { head :no_content }
    end
  end
end
