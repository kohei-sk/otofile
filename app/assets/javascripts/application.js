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
    })

    //ハンバーガー
    $('.nav_content').hide();

    $('.nav_btn_trriger').click(function () {
        if ($('.nav_btn_trriger').hasClass('active')) {
            $('.nav_content').fadeOut();
            $('.nav_btn_trriger').removeClass('active');
            $('body').removeClass('nav--opened');
        } else {
            $('.nav_content').fadeIn();
            $('.nav_btn_trriger').addClass('active');
            $('body').addClass('nav--opened');
        }
    });

    //タブ切り替え
    $(document).ready(function () {
        $('.is-show').show();
        $('.tab').click(function () {
            $('.is-active').removeClass('is-active');
            $(this).addClass('is-active');
            $('.panel').fadeOut(300);
            const index = $(this).index();
            $('.panel').eq(index).fadeIn(300);
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
        cellAlign: 'center',
        wrapAround: true,
        contain: true,
        prevNextButtons: false,
        pageDots: false
    });

    //ファイルアップロード ファイル名表示
    $('input').on('change', function () {
        var file = $(this).prop('files')[0];
        $('span.file').text(file.name);
    });

});