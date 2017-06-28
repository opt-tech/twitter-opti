WebsocketRails::EventMap.describe do
  subscribe :send_message, 'trends#new'
end
