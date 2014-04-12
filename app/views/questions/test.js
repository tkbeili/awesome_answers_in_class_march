:javascript
  $("h2").each(function(){
    console.log($(this).html());
  });

function generateUl(number) {
  var $ul = $("<ul></ul>");
  for(var i = 0; i < number; i++) {
    var $li = $("<li></li>", {text: "Element " + i});
    $ul.append($li);
  }
  $("body").append($ul);
}
generateUl(7);

$("h2:contains('abc')").each(function(){
  console.log($(this).text().length);
});

$("h2 a").each(function(){
  var capitalizedText = $(this).text().charAt(0).toUpperCase()  + 
                        $(this).text().slice(1);
  $(this).text(capitalizedText);
});

function removeH2() {
  var index = Math.floor(Math.random() * $("h2").length);
  if($("h2").length > 0) {
    $("h2")[index].remove();
  }
}