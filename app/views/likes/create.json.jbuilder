json.class "like"
json.post_id params[:id]
json.path "#{params[:id]}/unlike"
json.count @count

json.user_id current_user.id
json.userimg current_user.userimg.url(:m)
json.userid current_user.userid
json.username current_user.username

json.msg @msg.message
