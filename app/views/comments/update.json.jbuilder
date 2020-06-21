json.id @cmt.id
json.comment safe_join(@cmt.comment.split("\n"), tag(:br))
