# Set the host name for URL creation
# SitemapGenerator::Sitemap.default_host = "http://otofile.net"
SitemapGenerator::Sitemap.default_host = "https://otofile.net"
SitemapGenerator::Sitemap.sitemaps_host = "https://s3.amazonaws.com/otofile"
SitemapGenerator::Sitemap.public_path = "public/"
SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add root_path
  add welcome_path

  User.find_each do |user|
    add "/#{user.userid}", lastmod: user.updated_at
  end

  Post.find_each do |post|
    add "/p/#{post.id}", lastmod: post.updated_at
  end
end
