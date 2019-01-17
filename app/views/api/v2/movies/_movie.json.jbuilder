json.id movie.id
json.title movie.title
json.genre do
  json.id movie.genre_id
  json.name movie.genre_name
  json.movies_count Genre.movies_count.detect { |genre| genre[:id] == movie.genre_id }[:count]
end
