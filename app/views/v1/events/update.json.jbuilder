json.status 200
json.message 'Events Updated Successfully'
json.data do
  json.event do
    json.id @event.id
    json.title @event.title
    json.description @event.description
    json.start_time @event.start_time
    json.end_time @event.end_time
  end
end
