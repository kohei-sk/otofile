json.class "like"
json.post_id params[:id]
json.path "#{params[:id]}/unlike"
json.count @count

json.user_id current_user.id
json.userimg current_user.userimg.url(:m)
json.userid current_user.userid

if current_user.username.blank?
  json.username current_user.userid
else
  json.username current_user.username
end

if @msg.present?
    if @msg.message.blank?
        json.msg "ひとことがありません"
    else
        json.msg safe_join(@msg.message.split("\n"),tag(:br))
    end
else
    json.msg "ひとことがありません"
end

