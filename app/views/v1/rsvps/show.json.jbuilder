json.status 200
json.data do
  json.rsvp do
    json.id @rsvp.id
    json.attending @rsvp.attending
    json.event_id @rsvp.event_id
    json.user_id @rsvp.user_id
  end
end
