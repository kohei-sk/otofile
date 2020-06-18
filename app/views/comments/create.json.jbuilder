json.id @cmt.id
json.post_id @cmt.post_id
json.comment safe_join(@cmt.comment.split("\n"), tag(:br))
json.created_at @cmt.created_at.strftime("%Y-%m-%d")
json.count @count.count

json.userid @user.userid
json.username @user.username
json.userimg @user.userimg.url(:m)
