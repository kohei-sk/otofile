json.user_id @user.id
json.userimg @user.userimg.url(:m)
json.userid @user.userid

if @user.username.blank?
  json.username @user.userid
else
  json.username @user.username
end

json.id @post.id
json.title @post.title
json.comment safe_join(@post.comment.split("\n"), tag(:br))
json.created_at time_ago_in_words(@post.created_at)
