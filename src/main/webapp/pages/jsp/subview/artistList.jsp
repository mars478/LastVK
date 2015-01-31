<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div>
    <table style="border: 0">
        <c:if test="${((not (table eq null)) and (table.size() gt 0) )}">
            <c:forEach items="${table}" var="row" varStatus="stat">
                <tr>
                    <td><input id="artist${stat.index+1}" placeholder="artist" style="width: 200px" value="${row}"/></td>
                    <td><button type="button" onclick="inpForm.delete(this)">x</button></td>
                </tr>
            </c:forEach>
        </c:if>
        <tr id="defArtistRow">
            <td><input id="artist0" placeholder="artist" style="width: 200px"/></td>
            <td><button type="button" onclick="inpForm.delete(this)" >x</button></td>
        </tr>
    </table>
    <table style="border: 0">
        <tr>
            <td> <button type="button" onclick="inpForm.submit()">Start</button></td>
            <td><button type="button" onclick="inpForm.add(this)">+</button></td>
        </tr>  
    </table>
</div>

<script type="text/javascript" defer>
    var inpForm = new (function (defRowId, inpPref) {
        'use strict';
        if (!defRowId || !inpPref) {
            console.warn('inpForm init error');
            return {};
        }
        var self = this;
        this.defRowId = defRowId;
        this.inpPref = inpPref;

        this.delete = function (source) {
            $(source).closest("tr").not("#" + defRowId).remove();
        };

        this.add = function () {
            var tr = $('#' + defRowId);
            var rows = $('[id^="' + self.inpPref + '"]');
            var newTr = tr.clone().removeAttr('id');
            newTr.find('input').val('').attr('id', self.inpPref + (rows.size() + 1));
            tr.closest("table").append(newTr);
        };

        this.getData = function () {
            var artists = [];
            $('[id^="artist"]').each(function (ind, el) {
                artists[ind] = el.value;
            });
            return artists;
        };

        this.submit = function () {
            $.ajax({
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                'dataType': 'json',
                url: "/LastVK/loadArtistList",
                method: "POST",
                data: JSON.stringify(self.getData()),
                beforeSend: blockApp,
                complete: unblockApp,
                success: function (data, textStatus, response) {
                    console.log('success');
                    $('#mainPanel').html(response.responseText);
                },
                error: function (response) {
                    console.warn('alist jsp get fail:', response);
                    $('#mainPanel').html(response.responseText);
                }
            });
        };

        return {
            delete: self.delete,
            add: self.add,
            submit: self.submit
        }
    })("defArtistRow", "artist");
</script>