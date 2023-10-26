document.getElementById('myForm').addEventListener('submit', function(e) {
    e.preventDefault();
    var date = new Date();
    document.getElementById('displayText').innerHTML = "Sent on: " + date + "<br>";
    for (var i = 0; i < 3; i++) {
        var text = document.getElementById('text_' + i).value;
        document.getElementById('displayText').innerHTML += "text_" + i + ": " + text + "<br>";
    }
    for (var i = 0; i < 3; i++) {
        var checkbox = document.getElementById('checkbox_' + i);
        if (checkbox.checked) {
            document.getElementById('displayText').innerHTML += "checkbox_" + i + ": " + "checked" + "<br>";
        }
    }
  });
