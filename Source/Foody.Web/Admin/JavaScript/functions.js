
$(document).ready(function () {

    //$("select").uniform({ resetSelector: 'input[type="checkbox"]' });

    $(".touchpin").TouchSpin({
        initval: 0,
        max: 9000000000
    });

});

//#region Load proccess bar pannel

//OnUpdating Process
function OnUpdating() {
    $("body").addClass("loading");
}

//OnUpdated Process
function OnUpdated() {
    $("body").removeClass("loading");
}

//#endregion

function checkAll(n, fldName) {
    if (!fldName) {
        fldName = 'cb';
    }
    var f = document.getElementById('aspnetForm');
    var c = f.checkedAll.checked;
    var n2 = 0;
    for (i = 0; i < n; i++) {
        cb = eval('f.' + fldName + '' + i);
        if (cb) {
            cb.checked = c;
            n2++;
        }
    }
    if (c) {
        f.boxchecked.value = n2;
    } else {
        f.boxchecked.value = 0;
    }
}

function checkNumericKeyInfo($char, $mozChar) {
    if ($mozChar != null) { // Look for a Mozilla-compatible browser
        if (($mozChar >= 48 && $mozChar <= 57) || $mozChar == 0 || $mozChar == 8 || $mozChar == 13)
            return true;
        else
            return false;
    }
    else { // Must be an IE-compatible Browser
        if (($char >= 48 && $char <= 57) || $char == 0 || $char == 8 || $char == 13)
            return true;
        else
            return false;
    }
}

function isChecked(isitchecked) {
    if (isitchecked == true) {
        //alert("adfdfdsf:" + document.adminForm);
        document.aspnetForm.boxchecked.value++;
    }
    else {
        document.aspnetForm.boxchecked.value--;
    }
}

function listItemTask(id, task) {
    var f = document.getElementById('aspnetForm');
    cb = eval('f.' + id);
    if (cb) {
        for (i = 0; true; i++) {
            cbx = eval('f.cb' + i);
            if (!cbx) break;
            cbx.checked = false;
        } // for
        cb.checked = true;
        f.id.value = cb.value;
        f.boxchecked.value = 1;
        submitButton(task);
    }
    return false;
}

function submitForm(frm, task) {
    try {
        frm.task.value = task;
        frm.onsubmit();
    }
    catch (e) { }
    frm.submit();
}

function checkSelectedItem(msg) {
    if (document.getElementById('aspnetForm').boxchecked.value == 0) {
        alert(msg);
        return false;
    }
    return true;
}

function isValidEmail(str) {
    var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    if (filter.test(str)) {
        return true;
    } else {
        return false;
    }
}

function isNumeric(str) {
    var filter = new RegExp("^\\d{1,15}$");
    if (filter.test(str)) {
        return true;
    } else {
        return false;
    }
}

function isEmpty(str) {
    if ((str == null) || (str.replace(/(^\s*)|(\s*$)/g, "").length == 0)) {
        return true;
    } else {
        return false;
    }
}

function checkLength(str, minlen, maxlen) {
    if (str == null) return false;
    var l = str.length;
    var blen = 0;
    for (i = 0; i < l; i++) {
        if ((str.charCodeAt(i) & 0xff00) != 0) {
            blen++;
        }
        blen++;
    }
    if (blen > maxlen || blen < minlen) {
        return false;
    }
    return true;
}

function validateNickname(str) {
    var patn = /^[a-zA-Z0-9]+$/;
    if (patn.test(str)) {
        if (checkLength(str, 4, 50)) return true;
    }
    return false;
}

function checkEnter(e) { //e is event object passed from function invocation
    var characterCode //literal character code will be stored in this variable

    if (e && e.which) { //if which property of event object is supported (NN4)
        e = e;
        characterCode = e.which;  //character code is contained in NN4's which property
    }
    else {
        e = event;
        characterCode = e.keyCode;  //character code is contained in IE's keyCode property
    }
    if (characterCode == 13) { //if generated character code is equal to ascii 13 (if enter key)
        submitButton('search'); //submit the form
        return false;
    }
    else {
        return true;
    }
}

//#region Textbox đăng nhập nhấn enter

function checkEnterLogin(e) {
    e = e || window.event;
    if (e.keyCode == 13) {
        document.getElementById('btnLogin').click();
        return false;
    }
    return true;
}

//#endregion