json.status 200
json.data do
  json.events @events.each do |event|
    json.id event.id
    json.title event.title
    json.description event.description
    json.start_time event.start_time
    json.end_time event.end_time
    json.attending event.rsvps.where(attending: true).count
    end
  # json.limit_value @events.limit_value
  # json.total_pages @events.total_pages
  # json.current_page @events.current_page
  # json.next_page @events.next_page
  # json.prev_page @events.prev_page
  # json.first_page? @events.first_page?
  # json.last_page? @events.last_page?
  # json.out_of_range? @events.out_of_range?
end
