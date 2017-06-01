json.extract! book, :id, :title, :like_count, :editable,
                    :created_at, :updated_at
json.url book_url(book, format: :json)
