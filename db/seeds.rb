require "json"
require "rest-client"

# TODO: Write a seed to insert 10 posts in the database fetched from the Hacker News API.
require 'open-uri'

url = 'https://hacker-news.firebaseio.com/v0/topstories.json'
user_serialized = open(url).read
user = JSON.parse(user_serialized)

top_ten = user.first(10)
top_ten.each do |post|
  api_url = "https://hacker-news.firebaseio.com/v0/item/#{post}.json"
  api_user_serialized = open(api_url).read
  api_user = JSON.parse(api_user_serialized)
  post = Post.create(
    title: api_user["title"],
    url: api_user["url"],
    votes: api_user["score"]
  )
end
