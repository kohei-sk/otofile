module ApplicationHelper

    def default_meta_tags
        {
            site: 'Otofile（オトファイル）',
            title: '音楽好きと繋がるオンラインコミュニティ',
            reverse: true,
            charset: 'utf-8',
            description: '音楽好きの「スキ」をシェアするオンラインコミュニティ。ライブの感想、好きな曲・動画・画像を投稿して繋がれる。',
            keywords: 'フェス,ライブ,音楽',
            canonical: request.original_url,
            separator: '|',
              icon: [
                { href: image_url('favicon.png') },
                { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
              ],
            og: {
                site_name: :site,
                title: :title,
                description: :description,
                type: 'website',
                url: request.original_url,
                image: image_url('ogp.jpg'),
                locale: 'ja_JP',
            },
            # twitter: {
            #     card: 'summary',
            #     site: '@hogehoge',
            # }
        }
    end
end
