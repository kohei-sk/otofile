let ytlist = [];

let tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
let firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

let player;

function onYouTubeIframeAPIReady() {
    player = new YT.Player('ytbox', {
        height: '360',
        width: '640',
        events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange,
            'onError': onPlayerError
        }
    });
}

function onPlayerReady() {

    $.ajax({
            url: '/ytlist',
            type: "GET",
            dataType: 'json',
            processData: false,
            contentType: false
        })
        .done(function (data) {

            ytlist.push(data.ytid);
            ytlist.push(data.postid);

            player.cuePlaylist({
                'playlist': ytlist[0]
            });

            player.setLoop({
                'loopPlaylists': true
            })
        })
        .fail(function () {
            alert('エラーが発生しました');
        })
}

function onPlayerStateChange(event) {

    let ytStatus = event.data;

    if (ytStatus == YT.PlayerState.CUED) {
        player.playVideo();
    }

    if (ytStatus == YT.PlayerState.PLAYING || ytStatus == YT.PlayerState.CUED) {
        let i = player.getPlaylistIndex();
        let postid = ytlist[1][i];

        $.ajax({
                url: '/ytpost',
                type: "POST",
                dataType: 'json',
                data: {
                    id: postid
                }
            })

            .done(function (data) {

                let html = ytPost(data);
                $('.ac_content').remove();
                $('.ytbox_wrap').after(html);

            })
    }

}

function onPlayerError() {
    nextVideo();
}

function ytPost(post) {
    var html = `<div class="ac_content clearfix">
                    <div class="ac_content_wrap clearfix">
                        <p class="p_user_wrap clearfix">
                            <a href="/${post.userid}">
                                <span><img src="${post.userimg}"></span>
                                <span class="p_username">
                                    ${post.username}
                                    <span>${post.userid}</span>
                                </span>
                            </a>
                        </p>
                        <p class="ac_ttl">
                            <a href="/p/${post.id}">
                                ${post.title}
                            </a>
                        </p>
                        <div class="ac_content_inner">
                            <p class="ac_txt">${post.comment}</p>
                            <span class="date">${post.created_at}前</span>
                        </div>
                    </div>
                </div>`;

    return html
}