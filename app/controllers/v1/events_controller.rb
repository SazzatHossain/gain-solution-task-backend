class V1::EventsController < V1::BaseController
  before_action :authenticate_user, only: [:create, :update]

 def index
    per_page = params[:per_page] || 21
    page = params[:page] || 1
        ##### Get from date and to date search data #######
        from = if params.key?(:from_date) && params[:from_date] != ''
        then
                 params[:from_date].to_datetime.beginning_of_day
               else
                 100.years.ago.strftime('%Y-%m-%d')
               end

        to = if params.key?(:from_date) && params[:to_date] != ''
        then
               params[:to_date].to_datetime.end_of_day
             else
               100.years.since.strftime('%Y-%m-%d')
        end

    if params[:search]
      @events = Event.where('title LIKE ? OR location LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @events = Event.all
      render status: :ok
    end
  end

  def create
    user = User.find_by(id: @user.id)
    @event = user.events.create(events_params)
    @event.save!
  end

  def update
    @event = Event.find(params[:id])
    if @event.user_id == @user.id
       @event.update!(events_params)
    else
        render json: { status: 401, message: "You are no permitted to edit this post" }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

  end


  private
  def events_params
    params.required(:event).permit(:title, :description, :start_time, :end_time, :created_at, :updated_at)
  end

end
