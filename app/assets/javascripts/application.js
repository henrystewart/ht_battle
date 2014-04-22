// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

// function updateBattle() {  
//   $.getScript('/battle.js?battle_id=' + battle_id);  
//   setTimeout(updateComments, 10000);  
// }


// function updateBattle() {  
//   var battle_id = $('#battle').attr('data-id');  
//   // var after = $('.comment:last').attr('data-time');  
//   $.getScript('/battle.js?battle_id=' + battle_id);  
//   setTimeout(updateBattle, 10000);  
// } 


// $(function () {  
//   setTimeout(updateComments, 10000);
// });  
  
// function updateComments() {  
//   $.getScript('/battle.js');  
//   setTimeout(updateComments, 10000);  
// }

$(function () {  
  if ($('#battle')) {  
  setTimeout(updateBattle, 10000);  
  }  
});  
  
function updateBattle() {  
  // $.getScript('/show_battle.js?battle_id=' + battle_id);
  var battle_id = $('#battle').attr('data-id');
  console.log(battle_id)
  $.ajaxSetup({ cache: true });
  $.getScript('/present.js?battle_id=' + battle_id, function(){},true);
  $.ajaxSetup({ cache: false });
  location.reload()
  setTimeout(updateBattle, 3000);
} 


  // function poll() {
  //   lasted_count = $('div#battle').data('id')
  //   $.getScript('/update_counts?battle_id=' + battle_id)
  // }

  // $(function(){setTimeout(poll,5000)})