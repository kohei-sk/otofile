// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require jquery.jscroll.min.js
//= require jquery_nested_form

//nested_form setting（フェードアウトできない）
// window.NestedFormEvents.prototype.insertFields = function (content, assoc, link) {
//     var target = $(link).data('target');
//     if (target) {
//         return $(content).appendTo($(target)).hide().fadeIn();
//     } else {
//         return $(content).insertBefore(link).hide().fadeIn();
//     }
// }
// window.NestedFormEvents.prototype.removeFields = function (e) {
//     var $link = $(e.currentTarget),
//         assoc = $link.data('association'); // Name of child to be removed

//     var hiddenField = $link.prev('input[type=hidden]');
//     hiddenField.val('1');

//     var field = $link.closest('.fields');
//     field.fadeOut();

//     field
//         .trigger({
//             type: 'nested:fieldRemoved',
//             field: field
//         })
//         .trigger({
//             type: 'nested:fieldRemoved:' + assoc,
//             field: field
//         });
//     return false;
// }

$(document).ready(function () {

    //フラッシュフェードアウト
    $(function () {
        setTimeout("$('.notice, .alert').fadeOut('slow')", 2500)
    });

    //メニュー
    $(function () {
        var btn1 = $('.nav_btn_trriger')
        var cont1 = $('.nav_content')
        var btn2 = $('.search_btn_trriger')
        var cont2 = $('.search_content')

        //ハンバーガー
        btn1.click(function () {
            if (btn1.hasClass('active')) {
                cont1.fadeOut();
                btn1.removeClass('active');
                $('body').removeClass('nav--opened');
            } else {
                cont1.fadeIn();
                btn1.addClass('active');
                $('body').addClass('nav--opened');
            }
            if (btn2.hasClass('active')) {
                cont2.fadeOut();
                btn2.removeClass('active');
            }
        });

        //検索
        btn2.click(function () {
            if (btn2.hasClass('active')) {
                cont2.fadeOut();
                btn2.removeClass('active');
                $('body').removeClass('nav--opened');
            } else {
                cont2.fadeIn();
                btn2.addClass('active');
                $('body').addClass('nav--opened');
            }
            if (btn1.hasClass('active')) {
                cont1.fadeOut();
                btn1.removeClass('active');
            }
        });
    });

    //検索フォーム空白
    $('.head_search').submit(function () {
        if ($(this).children("input[type='text']").val() === '') {
            return false;
        }
    });
    $('.head_search').children("input[type='text']").keypress(function (e) {
        if (e.which && e.which === 13 || e.keyCode && e.keyCode === 13) {
            if (!$(this).val().match(/\S/g)) {
                return false;
            }
        }
    });

    //タブ切り替え
    $(document).ready(function () {
        $('.is-show').show();
        $('.tab').click(function () {

            $(this).siblings('.is-active').removeClass('is-active');
            $(this).addClass('is-active');

            const panel = $(this).parent().next().children('.panel');
            const index = $(this).index();
            panel.hide();
            panel.eq(index).show();
        });
    });

    //アコーディオン
    $(document).ready(function () {
        var btn = $('form .down_btn')
        var box = '.down_content'
        btn.click(function () {
            if ($(this).hasClass('active')) {
                $(this).removeClass('active')
                $(this).next(box).slideUp();
            } else {
                $(this).addClass('active')
                $(this).next(box).slideDown();
            }
        });
    });

    //URL自動
    $(function () {
        $('.pr_content, .ac_txt, .panel-group p.event').each(function () {
            $(this).html($(this).html().replace(/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig, "<a href='$1' target='_blank'>$1</a>"));
        });
    });

    //Likes Modal
    // $('.m_btn').show(function () {
    //     const m_btn = $(this)
    //     const m_content = m_btn.next();
    //     m_btn.modaal({
    //         content_source: m_content
    //     });
    // });

    $(window).on('scroll', function () {
        $('.m_btn').show(function () {
            const m_btn = $(this)
            const m_content = m_btn.next();
            m_btn.modaal({
                content_source: m_content
            });
        });
    });

    //recommendスライダー
    var flkty = new Flickity('.main-carousel', {
        cellAlign: 'left',
        wrapAround: true,
        contain: true,
        prevNextButtons: false,
        pageDots: false
    });

    //ファイルアップロード ファイル名&サムネ表示
    $('input').on('change', function () {
        var btn = this
        var file = $(btn).prop('files')[0];
        $(btn).parent().next().text(file.name).hide().fadeIn();

        var reader = new FileReader();
        reader.readAsDataURL(btn.files[0]);
        reader.onload = function () {
            $(btn).parent().prev().html('<img src="' + reader.result + '">').hide().fadeIn();
        }
    });

    //無限スクロール
    $(function () {
        $('.page_wrap').jscroll({
            contentSelector: '.page_wrap',
            nextSelector: 'span.next a',
            autoTrigger: true,
            padding: 500,
            loadingHtml: '<div class="loader"></div>'
        });
    });

    //フォローボタン非同期
    $(function () {
        function followHTML(follow) {
            var html = `<a href="${follow.path}" class="follow_btn ${follow.class}"></a>`;
            return html
        }

        //Follow
        $(document).on("click", '.follow_btn.unfollow', function (e) {
            e.preventDefault();
            var url = $(this).attr('href');
            console.log(url);
            $.ajax({
                    url: url,
                    type: "GET",
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    var html = followHTML(data);
                    $("#follow_user_" + data.id).html(html);
                    unfollowBtn();
                })
                .fail(function () {
                    location.reload();
                })
        })

        //Unfollow
        $(document).on("click", '.follow_btn.follow', function (e) {
            e.preventDefault();
            var url = $(this).attr('href');
            console.log(url);
            $.ajax({
                    url: url,
                    type: "GET",
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    var html = followHTML(data);
                    $("#follow_user_" + data.id).html(html);
                    followBtn();
                })
                .fail(function () {
                    location.reload();
                })
        })

    });

    //コメント非同期
    $(function () {
        function buildHTML(comments) {
            var html = `<li class="comment_wrap clearfix" id="comment_id_${comments.id}">
                            <a href="/${comments.userid}" class="comment_user">
                                <span class="com_l"><img src="${comments.userimg}"></span>
                                <span class="com_r">
                                    <span>${comments.username}</span>
                                    <span>${comments.userid}</span>
                                </span>
                            </a>
                            <p class="comment_content">
                                <span class="comment">${comments.comment}</span>
                                <span class="date">${comments.created_at}</span>
                                <span class="cmt_in_edit"><i class="fas fa-edit"></i></span>
                                <a class="cmt_dlete_btn" href="/c/${comments.id}/destroy">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </p>
                            <form class="comment_edit" action="/c/${comments.id}/edit" accept-charset="UTF-8" method="post">
                                <input name="utf8" type="hidden" value="✓">
                                <input type="hidden" name="_method" value="patch">
                                <input type="hidden" name="authenticity_token" value="">
                                <div class="field">
                                    <textarea name="comment" id="comment">${comments.comment}</textarea>
                                </div>
                                <label>
                                    <button type="submit"></button>
                                    <span class="cmt_send_btn"><i class="fas fa-paper-plane"></i></span>
                                </label>
                                <span class="cmt_close_btn"><i class="fas fa-times"></i></span>
                            </form>
                        </li>`;
            return html
        }

        function buildCount(comments) {
            var count = `<a href="/p/${comments.post_id}" class="cmt">
                            <i class="fas fa-comment"></i>
                            <span>${comments.count}</span>
                        </a>`
            return count;
        }

        //投稿
        $(".comment_area").on("submit", function (e) {

            //コメントフォーム空白
            if ($(this).children('.field').children('textarea').val() === '') {
                return false;
            }

            e.preventDefault();
            var formData = new FormData(this);
            var url = $(this).attr('action');
            var value = $(this).children('input[name="authenticity_token"]').val();
            $.ajax({
                    url: url,
                    type: "POST",
                    data: formData,
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    var html = buildHTML(data);
                    var count = buildCount(data);
                    $(html).prependTo('.comment_container').hide().fadeIn(500);
                    $('form[action="/c/' + data.id + '/edit"] input[name="authenticity_token"]').val(value);

                    $('.p_cmt_box').html(count).show();
                    $('textarea#post_id_' + data.post_id).val("");
                })
                .fail(function () {
                    location.reload();
                })
        })

        //編集
        $(document).on("submit", '.comment_edit', function (e) {
            e.preventDefault();
            var formData = new FormData(this);
            var url = $(this).attr('action');
            $.ajax({
                    url: url,
                    type: "PATCH",
                    data: formData,
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    const id = 'li#comment_id_' + data.id
                    $(id + ' .comment').html(data.comment);
                    $(id + ' textarea').html(data.comment);
                    $(id + ' form').hide();
                    $(id + ' .comment_content').fadeIn(500);

                })
                .fail(function () {
                    location.reload();
                })
        })

        //削除
        $(document).on("click", '.cmt_dlete_btn', function (e) {
            alert('本当に削除しますか？');
            e.preventDefault();
            var url = $(this).attr('href');
            $.ajax({
                    url: url,
                    type: "GET",
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    var count = buildCount(data);
                    $('li#comment_id_' + data.id).fadeOut(500);
                    $('.p_cmt_box').html(count).show();

                })
                .fail(function () {
                    location.reload();
                })
        })
    });

    //コメント編集ボックス表示非表示
    $(document).on("click", '.cmt_in_edit', function () {
        //$('.cmt_in_edit').click(function () {
        var edit = $(this).parent('p')
        edit.hide();
        edit.next('form').fadeIn(500);
        $('.cmt_close_btn').click(function () {
            var close = $(this).parent('form')
            close.hide();
            close.prev('p').fadeIn(500);
        });
    });


    //いいね非同期
    $(function () {
        function heartHTML(likes) {
            var heart = `<a class="${likes.class}" href="/p/${likes.path}">
                            <i class="fas fa-heart"></i>
                            <span>${likes.count}</span>
                        </a>`;
            return heart
        }

        function likeHTML(likes) {
            var like = `<span class="like_user_in" id="like_user_${likes.user_id}"><img src="${likes.userimg}"></span>`;
            return like
        }

        function mordalHTML(likes) {
            var mordal = `<li id="like_user_list_${likes.user_id}">
                            <a href="/${likes.userid}">
                                <span><img src="${likes.userimg}"></span>
                                <div>
                                    <span>${likes.username}</span>
                                    <span>${likes.userid}</span>
                                    <span>${likes.msg}</span>
                                </div>
                            </a>
                        </li>`;
            return mordal
        }

        //Like
        $(document).on("click", '.unlike', function (e) {
            e.preventDefault();
            const url = $(this).attr('href');
            $.ajax({
                    url: url,
                    type: "GET",
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    const heart = heartHTML(data);
                    const like = likeHTML(data);
                    const mordal = mordalHTML(data);
                    id = "#ac_post_" + data.post_id
                    $(id + " .p_like_box_wrap").html(heart);
                    $(like).prependTo(id + " .like_user").hide().fadeIn(500);
                    $(id + " .m_content ul").prepend(mordal);

                })
                .fail(function () {
                    location.reload();
                })
        })

        //Unlike
        $(document).on("click", '.like', function (e) {
            e.preventDefault();
            const url = $(this).attr('href');
            $.ajax({
                    url: url,
                    type: "GET",
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    const heart = heartHTML(data);
                    const id = "#ac_post_" + data.post_id
                    $(id + " .p_like_box_wrap").html(heart);
                    $(id + " #like_user_" + data.user_id).fadeOut(500, function () {
                        $(this).remove();
                    });
                    $(id + " #like_user_list_" + data.user_id).remove();

                })
                .fail(function () {
                    location.reload();
                })
        })

    });

});