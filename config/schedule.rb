set :output, "log/crontab.log"
every 1.day, at: "11:00 pm" do
  rake "-s sitemap:refresh"
end
