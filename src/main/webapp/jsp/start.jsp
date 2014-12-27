<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="<c:url value="/resources/css/page.css" />" rel="stylesheet">
        <script src="<c:url value="/resources/js/jquery-2.1.1.min.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LastVK</title>
    </head>
    <body>
        <div id="mainContainer">
            <div id="header" class="mainDiv">
                Header
            </div>
            <div id="leftMenu" class="mainDiv">
                <ul>
                    <li>
                        <button onclick="button_onclick()">last.fm</button>
                    </li>
                    <li>
                        <button>Artist list</button>
                    </li>
                    <li>
                        <button>Recommendations</button>
                    </li>
                </ul>
            </div>
            <div id="mainPanel" class="mainDiv">
                33=${lastfm}
                <c:if test="${lastfm}">
                    <div style="display: block; background: red">
                        test inner
                    </div>
                </c:if>
            </div>
            <div id="footer" class="mainDiv">
                footer

                <script src="//vk.com/js/api/openapi.js" type="text/javascript"></script>

                <div id="login_button" onclick="VK.Auth.login(authInfo);"></div>

                <script language="javascript">
                    VK.init({
                        apiId: 4645748
                    });
                    var sessionId = undefined;
                    function authInfo(response) {
                        console.log('response');
                        console.log(response);

                        if (response.session) {
                            sessionId = response.session.mid;
                            console.log('user: ' + sessionId);
                        } else {
                            console.log('not auth');
                        }

                        $.ajax({
                            url: "https://api.vk.com/oauth/access_token?client_id=" + response.session.mid + "&client_secret=3OsrfasRZzQDQcaHqDMu",
                            method: "GET",
                            success: function (data, textStatus, response) {
                                console.log('response2');
                                console.log(response);
                            },
                            error: function (response) {
                                console.warn(response);
                            }
                        });
                    }
                    VK.Auth.getLoginStatus(authInfo);
                    VK.UI.button('login_button');
                </script>

            </div>
        </div>

        <script type="text/javascript">
            function button_onclick() {
                $.ajax({
                    headers: {Accept: "text/plain; charset=utf-8", "Content-Type": "text/plain; charset=utf-8"},
                    url: "/LastVK/reload",
                    method: "POST",
                    success: function (data, textStatus, response) {
                        if (response.responseText === "") {
                            return;
                        }
                        $("#mainPanel").html($($.parseHTML(response.responseText)).find("#mainPanel").html());
                    },
                    error: function (response) {
                        console.warn(response);
                    }
                });
            }

            function callbackFunc(result) {
                console.log(result);
            }

            function testVk() {
                var search = 'the doors';
                var query = 'https://api.vk.com/method/audio.search?q=' + encodeURI(search) + '?count=1&access_token=' + sessionId;

                var script = document.createElement('SCRIPT');
                script.src = query + "&callback=callbackFunc";

                document.getElementsByTagName("head")[0].appendChild(script);
            }

            testVk();

            function vkTest() { //176.117.127.158
                var search = 'the doors';
                var query = 'https://api.vk.com/method/audio.search?q=' + encodeURI(search) + '?count=1&access_token=' + sessionId;

                $.ajax({
                    headers: {'Accept': 'application/json',
                        'Access-Control-Allow-Origin': '176.117.127.158'/*,
                         'Access-Control-Allow-Methods': 'GET, POST',
                         'Access-Control-Allow-Credentials': 'true'*/},
                    url: query,
                    dataType: 'jsonp',
                    data: {},
                    method: "GET",
                    crossDomain: 'true',
                    success: function (data, textStatus, response) {
                        console.log('response:' + response.responseText);
                        if (response.responseText === "") {
                            return;
                        }
                        $("#mainPanel").html($($.parseHTML(response.responseText)).find("#mainPanel").html());
                    },
                    error: function (response) {
                        console.warn(response);
                    }
                });
            }


            function wtf() {
                function getXmlHttp() {
                    var xmlhttp;
                    try {
                        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {
                        try {
                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (E) {
                            xmlhttp = false;
                        }
                    }
                    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                        xmlhttp = new XMLHttpRequest();
                    }
                    return xmlhttp;
                }

                var search = 'the doors';
                var query = 'https://api.vk.com/method/audio.search?v=5.26&q=' + encodeURI(search) + '&count=1&access_token=' + sessionId;

                var xmlhttp = getXmlHttp();
                xmlhttp.open('GET', query, false);
                xmlhttp.setRequestHeader('Access-Control-Allow-Origin', 'http://176.117.127.158');
                xmlhttp.setRequestHeader('Access-Control-Max-Age', '3628800');
                xmlhttp.setRequestHeader('Access-Control-Allow-Methods', 'PUT, GET');
                xmlhttp.send();
                if (xmlhttp.status == 200) {
                    alert(xmlhttp.responseText);
                }
            }
        </script>


    </body>
</html>
