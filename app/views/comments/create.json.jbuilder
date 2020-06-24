json.id @cmt.id
json.post_id @cmt.post_id
json.comment safe_join(@cmt.comment.split("\n"), tag(:br))
json.created_at @cmt.created_at.strftime("%Y-%m-%d")

json.userid @user.userid

if @user.username.empty?
  json.username @user.userid
else
  json.username @user.username
end

json.userimg @user.userimg.url(:m)
