json.id @reply.id
json.comment_id @reply.comment_id
json.reply safe_join(@reply.reply.split("\n"), tag(:br))
json.created_at @reply.created_at.strftime("%Y-%m-%d")

json.userid @user.userid

if @user.username.empty?
  json.username @user.userid
else
  json.username @user.username
end

json.userimg @user.userimg.url(:m)
