json.array!(@alarms) do |alarm|
  json.extract! alarm, :id, :subject_code, :lecturer, :alarmed, :email
  json.url alarm_url(alarm, format: :json)
end
