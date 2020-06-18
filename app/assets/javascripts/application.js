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
//= require turbolinks
//= require_tree .
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



$(document).on('turbolinks:load', function () {

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

    //コメントフォーム空白
    $('.comment_area').submit(function () {
        if ($(this).children('.field').children('textarea').val() === '') {
            return false;
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

    //likes Modal
    $('.m_btn').show(function () {
        const m_btn = $(this)
        const m_content = m_btn.next();
        m_btn.modaal({
            content_source: m_content
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
                                ${comments.comment}
                                <span class="date">${comments.created_at}</span>
                                <a href="/c/${comments.id}/edit" class="cmt_in_edit">Edit</a>
                            </p>
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

        function buildPostIdArea(comments) {
            var postIdArea = comments.post_id
            return postIdArea;
        }

        $(".comment_area").on("submit", function (e) {
            e.preventDefault();
            var formData = new FormData(this);
            var url = $(this).attr('action');
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
                    var postIdArea = buildPostIdArea(data);
                    $('.comment_container').prepend(html).hide().fadeIn();
                    $('.p_cmt_box').html(count).hide().fadeIn();
                    $('textarea#post_id_' + postIdArea).val("")
                })
                .fail(function () {
                    location.reload();
                })
        })
    });

    //コメント編集非同期
    $('.cmt_in_edit').click(function () {
        var edit = $(this).parent('p')
        edit.hide();
        edit.next('form').show();
        $('.cmt_close_btn').click(function () {
            var close = $(this).parent('form')
            close.hide();
            close.prev('p').show();
        });
    });

    // $(function () {
    //     function buildHTML(comments) {
    //         var html = `<li class="comment_wrap clearfix" id="comment_id_${comments.id}">
    //                         <a href="/${comments.userid}" class="comment_user">
    //                             <span class="com_l"><img src="${comments.userimg}"></span>
    //                             <span class="com_r">
    //                                 <span>${comments.username}</span>
    //                                 <span>${comments.userid}</span>
    //                             </span>
    //                         </a>
    //                         <p class="comment_content">
    //                             ${comments.comment}
    //                             <span class="date">${comments.created_at}</span>
    //                             <a href="/c/${comments.id}/edit" class="cmt_in_edit">Edit</a>
    //                         </p>
    //                     </li>`;
    //         return html
    //     }

    //     $(".comment_area").on("submit", function (e) {
    //         e.preventDefault();
    //         var formData = new FormData(this);
    //         var url = $(this).attr('action');
    //         $.ajax({
    //                 url: url,
    //                 type: "POST",
    //                 data: formData,
    //                 dataType: 'json',
    //                 processData: false,
    //                 contentType: false
    //             })
    //             .done(function (data) {
    //                 var html = buildHTML(data);
    //                 $('.comment_container').prepend(html);
    //                 $('.p_cmt_box').html(count);
    //                 $('textarea#post_id_' + postIdArea).val("")
    //             })
    //             .fail(function () {
    //                 location.reload();
    //             })
    //     })
    // });


});