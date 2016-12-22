function flash(color , msg){
    $.amaran({
        'theme'     :'colorful',
        'content'   :{
            bgcolor:color,
            color:'#fff',
            message:msg
        },
        'cssanimationOut'   :'slideRight',
        'outEffect'         :'slideRight',
        'closeOnClick'  :true,
        'position'          :'top right',
        'closeButton': true
    });
}
function flash_error(msg){
    color = '#D04B2B';
    flash(color,msg);
}
function flash_success(msg){
    color = '#80C14B';
    flash(color,msg);
}function flash_alert(msg){
    color = '#FFC333';
    flash(color,msg);
}
function flash_info(msg){
    color = '#35A4DA';
    flash(color,msg);
}
function flash_notice(msg){
    color = '#80C14B';
    flash(color,msg);
}