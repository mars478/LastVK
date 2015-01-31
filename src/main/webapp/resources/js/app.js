var jspLoad = function (path) {
    $.ajax({
        url: "/LastVK/" + path,
        method: "POST",
        success: function (data, textStatus, response) {
            console.log(path + ':success');
            $('#mainPanel').html(response.responseText);
        },
        error: function (response) {
            console.warn(path + ' jsp get fail:');
            console.warn(response);
        }
    });
}

var Controller = Backbone.Router.extend({
    routes: {
        "": "start", // Пустой hash-тэг
        "!/": "start", // Начальная страница
        "!/success": "success", // Блок удачи
        "!/error": "error", // Блок ошибки
        "!/push": "push", // затолкать
        "!/pull": "pull", // вытянуть
        "!/alist": "alist", // ввод списка исполнителей
        "!/lastfm": "lastfm" // ввод имени пользователя
    },
    lastfm: function () {
        console.log('lastfm');
        jspLoad('lastfm');
    },
    alist: function () {
        console.log('alist!');
        jspLoad('alist');
    },
    start: function () {
        console.log('start!');
        $(".block").hide(); // Прячем все блоки
        $("#start").show(); // Показываем нужный
    },
    success: function () {
        console.log('success!');
        $(".block").hide();
        $("#success").show();
    },
    error: function () {
        $(".block").hide();
        $("#error").show();
    },
    push: function () {
        $.ajax({
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            'dataType': 'json',
            url: "/LastVK/test/",
            method: "POST",
            data: JSON.stringify({artist: '123', title: '234'}),
            success: function (data, textStatus, response) {
                alert('push success:' + response);
            },
            error: function (response) {
                console.warn('push fail:');
                console.warn(response);
            }
        });
    },
    pull: function () {
        $.ajax({
            url: "/LastVK/test/1",
            method: "GET",
            success: function (data, textStatus, response) {
                alert('pull success:' + response);
            },
            error: function (response) {
                console.warn('pull fail:');
                console.warn(response);
            }
        });
    }
});

var controller = new Controller(); // Создаём контроллер

Backbone.history.start();  // Запускаем HTML5 History push    