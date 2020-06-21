json.class "unlike"
json.post_id params[:id]
json.user_id current_user.id
json.count @count
json.path "#{params[:id]}/like"
