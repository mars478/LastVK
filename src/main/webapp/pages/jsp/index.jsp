<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="resources/css/page.css" rel="stylesheet" type="text/css" /> 
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/underscore.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/backbone.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/app.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/view/new.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/utils.js" />"></script>

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
                    <li><a href="#!/">Index</a></li>
                    <li><a href="#!/lastfm">last.fm</a></li>
                    <li><a href="#!/alist">Artist list</a></li>
                    <!--li><a href="#!/recs">Recommendations</a></li>
                    <li><a href="#!/success">Success</a></li>
                    <li><a href="#!/error">Error</a></li-->
                </ul>
            </div>
            <div id="mainPanel" class="mainDiv">


                <div id="start" class="block">
                    <div class="userplace">
                        <c:if test="${lastfm}">
                            <div style="display: block; background: red">
                                test inner
                            </div>
                        </c:if>
                    </div>
                </div>
                <div id="error" class="block">
                    Ошибка такой пользователь не найден.
                </div>
                <div id="success" class="block">
                    Пользователь найден.
                </div>



            </div>
            <div id="footer" class="mainDiv">
                footer


                <script src="//vk.com/js/api/openapi.js" type="text/javascript"></script>

                <div id="login_button" onclick="VK.Auth.login(authInfo);"></div>

                <script language="javascript">
                    VK.init({
                        apiId: 4645748
                    });
                    function authInfo(response) {
                        if (response.session) {
                            console.log('user: ' + response.session.mid);
                        } else {
                            console.log('not auth');
                        }
                    }
                    VK.Auth.getLoginStatus(authInfo);
                    VK.UI.button('login_button');
                </script>
            </div>
        </div>

        <script type="text/javascript">
            function reloadById(id) {
                console.timeline();
                console.profile();
                var wrapper = document.getElementById(id);
                if (!wrapper) {
                    return;
                }

                var xmlhttp = (window.XMLHttpRequest)
                        ? new XMLHttpRequest()
                        : new ActiveXObject("Microsoft.XMLHTTP");

                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4) {
                        if (xmlhttp.status == 200) {
                            var resp = xmlhttp.responseText;
                            if (resp !== "") {
                                wrapper.outerHTML = resp;
                                console.log('success:', resp);
                            }
                        } else {
                            console.warn(xmlhttp.responseText);
                        }
                    }
                }

                xmlhttp.open("GET", "<c:url value="/reload"/>/" + id, true);
                xmlhttp.send();
                console.timelineEnd();
                console.profileEnd();
            }
        </script>


    </body>
</html>
