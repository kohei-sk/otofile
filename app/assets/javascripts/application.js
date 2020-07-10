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
//= require jquery_nested_form

$(document).ready(function () {

    //フラッシュフェードアウト
    var notice = function () {
        $('.notice, .alert').fadeIn(500);
        setTimeout(function () {
            $('.notice, .alert').fadeOut(500).queue(function () {
                this.remove();
            });
        }, 3500);
        return false
    }
    notice();

    //メニュー
    $(function () {
        var btn1 = $('.nav_btn_trriger')
        var cont1 = $('.nav_content')
        var btn2 = $('.search_btn_trriger')
        var cont2 = $('.search_content')
        var btn3 = $('#sp_search_trriger')

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
            if (btn3.hasClass('active')) {
                cont2.fadeOut();
                btn3.removeClass('active');
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

        btn3.click(function () {
            if (btn3.hasClass('active')) {
                cont2.fadeOut();
                btn3.removeClass('active');
                $('body').removeClass('nav--opened');
            } else {
                cont2.fadeIn();
                btn3.addClass('active');
                $('body').addClass('nav--opened');
            }
            if (btn1.hasClass('active')) {
                cont1.fadeOut();
                btn1.removeClass('active');
            }
        });
    });

    //サイドナビ固定
    $(window).scroll(function () {
        var headerH = $('header').outerHeight();
        var headerH2 = $('.home_head').outerHeight();
        var mainWrap = $('main').outerHeight() + headerH + headerH2;
        var sideNav = $('.aside_inner');
        var sideWrap = $('.aside_inner').outerHeight();
        var windowH = $(window).height();
        var scrollTop = $(this).scrollTop();
        var sideH = sideNav.outerHeight() + headerH + headerH2;

        if (sideH < mainWrap) {

            if (windowH > sideWrap) {
                if (headerH2 < scrollTop) {
                    sideNav.addClass('side_fixed_top');
                } else {
                    sideNav.removeClass('side_fixed_top');
                }
            } else {
                if (sideH - windowH < scrollTop) {
                    sideNav.addClass('side_fixed');
                } else {
                    sideNav.removeClass('side_fixed');
                }
            }

        }
    });

    //固定ボタン
    $(function () {
        $(document).on("click", '.fixed_nav_btn', function () {
            var b = $('.fixed_nav_btn')
            var c = $('.fixed_nav_content a')
            if (b.hasClass('active')) {
                b.removeClass('active');
                $('#fix_btn_msg').animate({
                    "top": "0px",
                    "opacity": "0"
                }, 300);
                $('#fix_btn_post').animate({
                    "top": "0px",
                    "opacity": "0"
                }, 300);
                $('#fix_btn_prf').animate({
                    "top": "0px",
                    "opacity": "0"
                }, 300);
                c.fadeOut();
            } else {
                b.addClass('active');
                c.show();
                $('#fix_btn_msg').animate({
                    "top": "-198px",
                    "opacity": "1"
                }, 300);
                $('#fix_btn_post').animate({
                    "top": "-132px",
                    "opacity": "1"
                }, 300);
                $('#fix_btn_prf').animate({
                    "top": "-66px",
                    "opacity": "1"
                }, 300);
                $(document).on('click', function (e) {
                    if (!$(e.target).closest('.fixed_nav_btn.active').length) {
                        $('.fixed_nav_btn.active').trigger('click');
                    }
                });
            }
        });
    });

    //投稿シェアボタン
    $(function () {
        $(document).on("click", '.ac_share_btn', function () {
            const ts = $(this);
            const cn = ts.next('.ac_share_content');
            const nm = 'active';
            const wp = ts.parent('.ac_share_wrap');
            const bg = $('.share_nobg')

            if (wp.hasClass(nm)) {
                cn.fadeOut(200);
                wp.removeClass(nm);
            } else {
                cn.fadeIn(200);
                wp.addClass(nm);
                bg.click(function () {
                    cn.fadeOut(200);
                    wp.removeClass(nm);
                });
            }

            //ボタン操作
            const id = cn.attr('id');
            const cp = ts.next().find('.ac_link_copy');
            const tt = ts.next().find('.ac_twitter').children('a');
            const li = location.host + id;
            const tx = ts.parent().parent().parent('.ac_content_wrap').children('.ac_ttl').text();

            //ツイッターシェア
            tt.attr('href', 'https://twitter.com/intent/tweet?text=' + tx + '&url=' + li);

            //リンクコピー
            cp.off();
            cp.click(function () {

                var cb = $('<textarea></textarea>');
                cb.text(li);
                cp.append(cb);
                cb.select();
                document.execCommand('copy');
                cb.remove();

                cn.fadeOut(200);
                wp.removeClass(nm);

                $('<p class="notice clearfix">コピーしました</p>').appendTo('header');
                notice();
            });
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

    //検索タブ切り替え
    $(document).ready(function () {
        $('.search_content .is-show').show();
        $('.search_content .tab').click(function () {
            $(this).siblings('.is_active').removeClass('is_active');
            $(this).addClass('is_active');

            const panel = $('.search_panel_group .panel');
            const index = $(this).index();
            panel.hide();
            panel.eq(index).show();
        });
    });

    //タブ切り替え
    $(function () {
        var tabMenu = function () {

            var $tabs = $('.tab-group');
            var $content = $('.panel-group .panel');
            var TAB_ACTIVE_CLASS = 'is_active';
            var CONTENT_SHOW_CLASS = 'is_show';
            var id_arr = $content.map(function () {
                return '#' + $(this).attr('id');
            }).get();

            var getHash = function () {
                var hash = window.location.hash;
                var index = id_arr.indexOf(hash);
                addEvent();

                if (index === -1) {
                    $tabs.find('li:first > a').trigger('click');
                    return false;
                } else {
                    $('a[href="' + hash + '"]').trigger('click');
                    return id_arr[index];
                }
            };

            var initialize = function () {
                var hash = getHash();

                if (hash) {
                    $tabs.find('a[href="' + hash + '"]').addClass(TAB_ACTIVE_CLASS);
                    $(hash).addClass(CONTENT_SHOW_CLASS);
                } else {
                    $tabs.find('li:first > a').addClass(TAB_ACTIVE_CLASS);
                    $($content[0]).addClass(CONTENT_SHOW_CLASS);
                }
            };

            var addEvent = function () {

                $tabs.find('a').on('click', function () {
                    var href = $(this).attr('href');
                    var $targetContent = $(href);

                    if ($(this).hasClass(TAB_ACTIVE_CLASS)) {
                        return false;
                    }

                    $tabs.find('a').removeClass(TAB_ACTIVE_CLASS);
                    $content.removeClass(CONTENT_SHOW_CLASS);

                    $(this).addClass(TAB_ACTIVE_CLASS);
                    $targetContent.addClass(CONTENT_SHOW_CLASS);

                    var firstLink = $tabs.find('li:first > a').attr('href');
                    if (href === firstLink) {
                        history.replaceState('tabs', '', location.pathname);
                    } else {
                        history.replaceState('tabs', '', location.pathname + href);
                    }

                    //無限スクロール発火
                    var click = $(this).data("click");
                    if (!click) {
                        $(this).data("click", true);

                        $(href + ' .page_wrap').infiniteScroll({
                            path: href + ' span.next a',
                            append: href + ' .page_wrap',
                            history: false,
                            scrollThreshold: 700,
                            status: href + ' .page_load_status'
                        });

                    }

                    return false;
                });
            };

            return [initialize(), addEvent()];
        };

        if ($('body .tab_content_wrap').length) {
            tabMenu();
            topNotice();
        } else {
            $('.page_wrap').infiniteScroll({
                path: 'span.next a',
                append: '.page_wrap',
                history: false,
                scrollThreshold: 700,
                status: '.page_load_status'
            });
        }

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

    //textarea高さ自動

    $("textarea.auto_height").on("autoheight", function (evt) {
        var target = evt.target;
        if (target.scrollHeight > target.offsetHeight) {
            $(target).height(target.scrollHeight - 19);
        }
    });

    $(document).ready(function () {
        $("textarea.auto_height").trigger('autoheight');
    });

    $("textarea.auto_height").autoExpand();

    $(document).on("click", '.add_nested_fields', function () {
        $("textarea.auto_height").autoExpand();
        $('html, body').animate({
            scrollTop: $('body').get(0).scrollHeight
        }, );
    });

    //モーダルコンテンツ
    mordal();

    $(window).on("scroll", function () {
        mordal();
    });

    function mordal() {
        var ua = navigator.userAgent;
        if ((ua.indexOf('iPhone') > 0 || ua.indexOf('iPad') > 0 || ua.indexOf('Android') > 0) && ua.indexOf('Mobile') > 0) {
            $('.m_img').magnificPopup({
                type: 'image',
                closeOnContentClick: true,
                fixedContentPos: true
            });
        } else {
            $('.m_img').magnificPopup({
                type: 'image',
                closeOnContentClick: true,
                fixedContentPos: true,
                zoom: {
                    enabled: true,
                    duration: 300
                }
            });
        }

        $('.m_btn').magnificPopup({
            type: 'inline',
            preloader: false,
            showCloseBtn: false,
            fixedContentPos: true
        });
    }

    $(document).on('click', '.m_close', function (e) {
        e.preventDefault();
        $.magnificPopup.close();
    });

    //recommendスライダー
    var flkty = new Flickity('.main-carousel', {
        cellAlign: 'left',
        wrapAround: true,
        contain: true,
        prevNextButtons: true,
        pageDots: false
    });
    var topNotice = function () {
        var flkty = new Flickity('.user_notice_wrapper', {
            cellAlign: 'left',
            wrapAround: true,
            contain: true,
            prevNextButtons: false,
            pageDots: false,
            adaptiveHeight: true
        });
    }

    //プロフカウター
    $(function () {
        $(document).ready(function () {
            var counter = $('.count_bar');
            var bar = counter.children('span');
            var percent = counter.attr('id').split('_')[1];

            setTimeout(function () {
                bar.css('width', `${percent}%`);
            }, 800);
        });
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

        $('.yt_select_wrap').fadeOut();
    });

    //画像かYouTubeかどっちか
    $(function () {
        const img_confirm = $('.img_wrap_confirm img');
        const yt_confirm = $('input#ytid').val();

        if (img_confirm[0]) {
            $('.yt_select_wrap').hide();
        }
        if (yt_confirm !== '') {
            $('.img_select_wrap').hide();
        }
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
            var comments_text = comments.comment.replace(/<br \/>/g, '')
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
                                <span class="date">${comments.created_at}前</span>
                                <span class="cmt_in_edit"><i class="fas fa-edit"></i></span>
                                <a class="cmt_dlete_btn" href="/c/${comments.id}/destroy">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                                <span class="cmt_in_reply"><i class="fas fa-reply"></i></span>
                                <span class="cmt_in_reply_close"><i class="fas fa-times"></i></span>
                            </p>
                            <form class="comment_edit" action="/c/${comments.id}/edit" accept-charset="UTF-8" method="post">
                                <input name="utf8" type="hidden" value="✓">
                                <input type="hidden" name="_method" value="patch">
                                <input type="hidden" name="authenticity_token" value="">
                                <div class="field">
                                    <textarea name="comment" id="comment" class="auto_height">${comments_text}</textarea>
                                </div>
                                <label>
                                    <button type="submit"></button>
                                    <span class="cmt_send_btn"><i class="fas fa-paper-plane"></i></span>
                                </label>
                                <span class="cmt_close_btn"><i class="fas fa-times"></i></span>
                            </form>
                            <form class="reply_area" id="new_reply" action="/r/${comments.post_id}/new" accept-charset="UTF-8" method="post">
                            <input name="utf8" type="hidden" value="✓">
                            <input type="hidden" name="authenticity_token" value="">
                                    <div class="field">
                                        <input value="${comments.id}" type="hidden" name="reply[comment_id]" id="reply_comment_id">
                                        <textarea placeholder="返信 :D" id="comment_id_${comments.id}", class="auto_height" name="reply[reply]"></textarea>
                                        <label>
                                            <button type="submit"></button>
                                            <span class="reply_send_btn"><i class="fas fa-paper-plane"></i></span>
                                        </label>
                                    </div>
                            </form>
                            <ul class="reply_container" id="reply_comment_id_${comments.id}"></ul>
                        </li>`;
            return html
        }

        function buildCount(comments, number) {

            var count = `<a href="/p/${comments.post_id}" class="cmt">
                            <i class="fas fa-comment"></i>
                            <span>${number}</span>
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
            var number = Number($('a.cmt span').text()) + 1;
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
                    var count = buildCount(data, number);
                    $(html).prependTo('.comment_container').hide().fadeIn(500);
                    $('form[action="/c/' + data.id + '/edit"] input[name="authenticity_token"]').val(value);
                    $('form[action="/r/' + data.post_id + '/new"] input[name="authenticity_token"]').val(value);

                    $('.p_cmt_box').html(count).show();
                    $('textarea#post_id_' + data.post_id).val("");
                    $('textarea#post_id_' + data.post_id + ".auto_height").autoExpand();
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
            e.preventDefault();
            var url = $(this).attr('href');
            var number = Number($('a.cmt span').text()) - 1;
            var id = $(this).attr('href').split('/')[2];
            $.ajax({
                    url: url,
                    type: "GET",
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    var count = buildCount(data, number);
                    $('li#comment_id_' + id).fadeOut(500).queue(function () {
                        this.remove();
                    });
                    $('.p_cmt_box').html(count).show();

                })
                .fail(function () {
                    location.reload();
                })
        })
    });

    //返信非同期
    $(function () {
        function replyHTML(replies) {
            var replies_text = replies.reply.replace(/<br \/>/g, '')
            var html = `<li class="reply_wrap clearfix" id="reply_id_${replies.id}">
                            <a class="reply_user" href="/${replies.userid}">
                                <span class="reply_l"><img src="${replies.userimg}"></span>
                                <span class="reply_r">
                                    <span>${replies.username}</span>
                                    <span>${replies.userid}</span>
                                </span>
                            </a>
                            <p class="reply_content" style="display: block;">
                                <span class="reply">${replies.reply}</span>
                                <span class="date">${replies.created_at}前</span>

                                <span class="reply_in_edit"><i class="fas fa-edit"></i></span>
                                <a class="reply_dlete_btn" data-confirm="本当に削除しますか？" href="/r/${replies.id}/destroy">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </p>
                            <form class="reply_edit" action="/r/${replies.id}/edit" accept-charset="UTF-8" method="post">
                                <input name="utf8" type="hidden" value="✓">
                                    <input type="hidden" name="_method" value="patch">
                                    <input type="hidden" name="authenticity_token" value="">
                                <div class="field">
                                    <textarea name="reply" id="reply" class="auto_height">${replies_text}</textarea>
                                </div>
                                <label>
                                    <button type="submit"></button>
                                    <span class="reply_send_btn"><i class="fas fa-paper-plane"></i></span>
                                </label>
                                <span class="reply_close_btn"><i class="fas fa-times"></i></span>
                            </form>
                        </li>`;
            return html
        }

        //投稿
        $(document).on("submit", '.reply_area', function (e) {

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
                    var html = replyHTML(data);
                    $(html).prependTo('#reply_comment_id_' + data.comment_id).hide().fadeIn(500);
                    $('form[action="/r/' + data.id + '/edit"] input[name="authenticity_token"]').val(value);

                    $('textarea#comment_id_' + data.comment_id).val("");
                    $('li#comment_id_' + data.comment_id + ' .cmt_in_reply_close').trigger('click');
                })
                .fail(function () {
                    location.reload();
                })
        })

        //編集
        $(document).on("submit", '.reply_edit', function (e) {
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
                    const id = 'li#reply_id_' + data.id
                    $(id + ' .reply').html(data.reply);
                    $(id + ' textarea').html(data.reply);
                    $(id + ' form').hide();
                    $(id + ' .reply_content').fadeIn(500);

                })
                .fail(function () {
                    location.reload();
                })
        })

        //削除
        $(document).on("click", '.reply_dlete_btn', function (e) {
            e.preventDefault();
            var url = $(this).attr('href');
            var id = $(this).attr('href').split('/')[2];
            $.ajax({
                    url: url,
                    type: "GET",
                    dataType: 'json',
                    processData: false,
                    contentType: false
                })
                .done(function (data) {
                    $('li#reply_id_' + id).fadeOut(500).queue(function () {
                        this.remove();
                    });

                })
                .fail(function () {
                    location.reload();
                })
        })
    });

    //コメント編集ボックス表示非表示
    $(document).on("click", '.cmt_in_edit', function () {
        var edit = $(this).parent('p')
        edit.hide();
        edit.next('form').fadeIn(500);
        edit.next('form').find('textarea.auto_height').autoExpand();
        $('.cmt_close_btn').click(function () {
            var close = $(this).parent('form')
            close.hide();
            close.prev('p').fadeIn(500);
        });
    });

    //返信ボックス表示非表示
    $(document).on("click", '.cmt_in_reply', function () {
        var btn = $(this);
        var close = $(this).next('.cmt_in_reply_close');
        var box = $(this).parent().siblings('.reply_area')

        box.fadeIn(500);
        box.find('textarea.auto_height').autoExpand();
        btn.fadeOut(500);
        close.fadeIn(500);

        close.click(function () {
            box.fadeOut(500);
            btn.fadeIn(500);
            close.fadeOut(500);
        });
    });

    //返信編集ボックス表示非表示
    $(document).on("click", '.reply_in_edit', function () {
        var edit = $(this).parent('p')
        edit.hide();
        edit.next('form').fadeIn(500);
        edit.next('form').find('textarea.auto_height').autoExpand();
        $('.reply_close_btn').click(function () {
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