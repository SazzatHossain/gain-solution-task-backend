class V1::RsvpsController < V1::BaseController
  before_action :authenticate_user, only: [:create, :update, :show_rsvp]

 def index
    @rsvps = Rsvp.all
  end


  def show
    event = Event.find(params[:event_id])
    @rsvp = event.rsvps.find(params[:id])
  end

def show_rsvp
      user = User.find_by(id: @user.id)
      event = Event.find(params[:event_id])
      if event.rsvps.where(user_id: @user.id).exists?
              result = {
                message: "true",
                status: "200"
              }
         render json: result, status: 409 and return
      else
              result = {
                message: "false",
                status: "409"
              }
         render json: result, status: 409 and return
      end
     end
  def create
      user = User.find_by(id: @user.id)
      event = Event.find(params[:event_id])
      if event.rsvps.where(user_id: @user.id).exists?
              result = {
                message: "Already responded",
                status: "409"
              }
         render json: result, status: 409 and return
      else
       @rsvp = event.rsvps.create(rsvp_params)
       @rsvp.user_id = user.id
       @rsvp.save!
      end
  end

  private
   def rsvp_params
    params.required(:rsvp).permit(:attending)
  end

end
