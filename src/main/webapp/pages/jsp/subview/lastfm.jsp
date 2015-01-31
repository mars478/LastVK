<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div>
    <table style="border: 0">
        <tr>
            <td> <input id="username" placeholder="lastfm username" style="width: 200px" /></td>
            <td><button type="button" onclick="usernameSubmit()">Start</button></td>
        </tr>
    </table>
</div>

<script type="text/javascript" defer>
    var usernameSubmit = function () {
        $.ajax({
            url: "/LastVK/loadUsername",
            method: "POST",
            data: {'username': $('#username')[0].value},
            beforeSend: blockApp,
            complete: unblockApp,
            success: function (data, textStatus, response) {
                console.log('success');
                $('#mainPanel').html(response.responseText);
            },
            error: function (response) {
                console.warn('lastfm jsp get fail:', response);
                $('#mainPanel').html(response.responseText);
            }
        });
    };
</script>