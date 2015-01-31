function reload(id) {
    $.ajax({
        headers: {Accept: "text/plain; charset=utf-8", "Content-Type": "text/plain; charset=utf-8"},
        url: "/LastVK/test/" + id,
        method: "POST",
        success: function (data, textStatus, response) {
            if (response.responseText !== "") {
                $("#" + id).html($($.parseHTML(response.responseText)).find("#" + id).html());
            }
        },
        error: function (response) {
            console.warn(response);
        }
    });
}

var blockApp = function () {
    $('body').append("<div id='blockDiv'></div><span id='blockText'><span>Wait</span></span>")
};

var unblockApp = function () {
    $('#blockDiv').remove();
    $('#blockText').remove();
}