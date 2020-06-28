json.id @reply.id
json.reply safe_join(@reply.reply.split("\n"), tag(:br))
