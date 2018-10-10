$(document).ready(function () {

    //$("#content-inner-row1Col").resizable();
    $("#content-inner-row1Col1").accordion({
        collapsible: true,
        active: 2,
        autoHeight: false,
        heightStyle: "content",
        navigation: true,
        beforeActivate: function (event, ui) {
            // The accordion believes a panel is being opened
            if (ui.newHeader[0]) {
                var currHeader = ui.newHeader;
                var currContent = currHeader.next('.ui-accordion-content');
                // The accordion believes a panel is being closed
            } else {
                var currHeader = ui.oldHeader;
                var currContent = currHeader.next('.ui-accordion-content');
            }
            // Since we've changed the default behavior, this detects the actual status
            var isPanelSelected = currHeader.attr('aria-selected') == 'true';

            // Toggle the panel's header
            currHeader.toggleClass('ui-corner-all', isPanelSelected).toggleClass('accordion-header-active ui-state-active ui-corner-top', !isPanelSelected).attr('aria-selected', ((!isPanelSelected).toString()));

            // Toggle the panel's icon
            currHeader.children('.ui-icon').toggleClass('ui-icon-triangle-1-e', isPanelSelected).toggleClass('ui-icon-triangle-1-s', !isPanelSelected);

            // Toggle the panel's content
            currContent.toggleClass('accordion-content-active', !isPanelSelected)
            if (isPanelSelected) { currContent.slideUp(); } else { currContent.slideDown(); }

            return false; // Cancels the default action
        }
    });

    $(".ui-accordion-header").css("background", "#ffb84d");
    $(".ui-widget-content").css("background", "#fff657");
    $(".ui-accordion-header.ui-state-active ").css("background", "#ff9900");

    $('#colorpicker').farbtastic('#color');



});



function setRectangleColor(picker) {

    //document.getElementsByTagName('body')[0].style.color = '#' + picker.toString()
}

function hideDive() {
    document.getElementById("dAngle").style.display = 'none';
}

function hidePopupDivNode() {
    document.getElementById("PopupDivNode").style.display = 'none';
}


