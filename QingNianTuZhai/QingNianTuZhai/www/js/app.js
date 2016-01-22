$(document).on('click', 'a', function (event) {
    var url = $(this).attr('href');
    var target = $(this).attr('target');
    if (target == '_blank') {
        window.webkit.messageHandlers.modal.postMessage(url);
    } else {
        window.webkit.messageHandlers.push.postMessage(url);
    }
    return false;
});