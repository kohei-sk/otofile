postid = []
ytid = []

@posts.each do |post|
  postid.push(post.id)
  ytid.push(post.ytid)
end

json.postid postid
json.ytid ytid
