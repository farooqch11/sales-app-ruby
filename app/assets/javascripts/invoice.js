function printDiv2(div) {
    var element = document.getElementById(div);
    var domClone = element.cloneNode(true);
    var $printSection = document.createElement("div");
    $printSection.id = "printSection";
    $printSection.appendChild(domClone);
    document.body.insertBefore($printSection, document.body.firstChild);
    window.print();

    var oldElement = document.getElementById('printSection');
    if (oldElement != null) { oldElement.parentNode.removeChild(oldElement);}

    return true;
}
function printDiv(divId) {
    var content = document.getElementById(divId).innerHTML;
    var oldPage = document.body.innerHTML;
    document.body.innerHTML = "<section class='vbox' style='border: 0px !important'><section class='hbox stretch' style='border: 0px !important'><section id='content' style='border: 0px !important'>"+content+"</section></section></section>";
    window.print();
    document.body.innerHTML = oldPage;
    return true;
}