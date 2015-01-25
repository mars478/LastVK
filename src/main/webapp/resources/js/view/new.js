var Start = Backbone.View.extend({
   // el: $("#start"), // DOM элемент widget'а
    events: {
        "click": "check" // Обработчик клика на кнопке "Проверить"
    },
    check: function () {
        console.log('check() fired');
        function isEmpty(str) {
            return (str && str.length() > 0);
        }

        var artist = this.el.find("#artist").val();
        var title = this.el.find("#title").val();

        if (!isEmpty(artist) && !isEmpty(title)) // Проверка текста
            controller.navigate("success", true); // переход на страницу success
        else
            controller.navigate("error", true); // переход на страницу error
    }
});

var start = new Start();