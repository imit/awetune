object @station
attributes :title, :media_id, :media_type
child @playlist do
  attributes :id, :title, :media_id, :media_url
end