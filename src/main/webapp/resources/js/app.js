var Controller = Backbone.Router.extend({
    routes: {
        "": "start", // Пустой hash-тэг
        "!/": "start", // Начальная страница
        "!/success": "success", // Блок удачи
        "!/error": "error", // Блок ошибки
        "!/push": "push", // затолкать
        "!/pull": "pull"  // вытянуть
    },
    start: function () {
        $(".block").hide(); // Прячем все блоки
        $("#start").show(); // Показываем нужный
    },
    success: function () {
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