json.array!(@equipment_line_items) do |equipment_line_item|
  json.extract! equipment_line_item, :id, :equipment_id, :equipment_move_buffer_id
  json.url equipment_line_item_url(equipment_line_item, format: :json)
end
