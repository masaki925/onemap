class PlandaysController < ApplicationController
  # GET /plandays/1
  # GET /plandays/1.json
  def show
    @planday = Planday.find(params[:id])

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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @planday }
    end
  end

  # GET /plandays/1/edit
  def edit
    @planday = Planday.find(params[:id])
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

    respond_to do |format|
      if @planday.update_attributes(params[:planday])
        format.html { redirect_to @planday, notice: 'Planday was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
