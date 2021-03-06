﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_sessiontimeout.ascx.cs" Inherits="Cb.Web.Controls.block_sessiontimeout" %>


<!---block_sessiontimeout-->
<div class="modal fade" id="idle-timeout-dialog" data-backdrop="static">
    <div class="modal-dialog modal-small">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Sorry but your session has expired…</h4>
            </div>
            <div class="modal-body">
                <p>
                    <i class="fa fa-warning font-red"></i>You session will be locked in
                                       
                                    <span id="idle-timeout-counter"></span>seconds.
                </p>
                <p>Do you want to continue your session? </p>
            </div>
            <div class="modal-footer">
                <button id="idle-timeout-dialog-logout" type="button" class="btn dark btn-outline sbold uppercase">No, Logout</button>
                <%--<button id="idle-timeout-dialog-keepalive" type="button" class="btn green btn-outline sbold uppercase" data-dismiss="modal">Yes, Keep Working</button>--%>
            </div>
        </div>
    </div>
</div>

<!---/block_sessiontimeout-->
