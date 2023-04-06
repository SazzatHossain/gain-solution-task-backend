json.status 200
json.data do
  json.event do
    json.id @event.id
    json.title @event.title
    json.description @event.description
    json.start_time @event.start_time
    json.end_time @event.end_time
    json.attending @event.rsvps.where(attending: true).count
  end
end
