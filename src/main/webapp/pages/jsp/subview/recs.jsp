<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div>
    <c:if test="${((not (table eq null)) and (table.size() gt 0) )}">
        <table style="border: 0">

            <c:forEach items="${table}" var="row" varStatus="stat">
                <tr>
                    <td>${row.artist.name}</td>
                    <td>${row.name}</td>
                    <td><a href="${row.artist.url}">link</a></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    <c:if test="${((table eq null) or (table.size() eq 0) )}">
        Failed.
    </c:if>
</div>