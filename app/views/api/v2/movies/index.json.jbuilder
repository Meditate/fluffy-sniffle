json.array! @movies do |movie|
  json.partial! "movie", movie: movie
end
