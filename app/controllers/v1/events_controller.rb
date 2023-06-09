class V1::EventsController < V1::BaseController
  before_action :authenticate_user, only: [:create, :update, :my_events_list]

 def index
    per_page = params[:per_page] || 6
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

    if params[:search] || params[:from_date]  || params[:to_date]
      @events = Event.page(page).per(per_page).where('title LIKE ? OR location LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").where(created_at: from..to)
    else
      @events = Event.page(page).per(per_page).all
      render status: :ok
    end
  end

  def my_events_list
     per_page = params[:per_page] || 6
     page = params[:page] || 1
    user = User.find_by(id: @user.id)
    if params[:search]
      @events = Event.page(page).per(per_page).where('title LIKE ? OR location LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").where(user_id: user.id)
    else
      @events = Event.page(page).per(per_page).where(user_id: user.id).all
      render status: :ok
    end
  end


  def create
    user = User.find_by(id: @user.id)
    @event = user.events.create(events_params)
    @event.user_id = user.id
    puts user
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
    params.required(:event).permit(:title, :location,:description, :start_time, :end_time)
  end
end
