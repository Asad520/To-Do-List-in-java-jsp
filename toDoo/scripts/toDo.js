// Create a "close" button and append it to each list item
var myNodelist = document.getElementsByTagName("LI");
var i;
for (i = 0; i < myNodelist.length; i++) {
  var div = document.createElement("Div");
  var txt = document.createTextNode("x");
  div.className = "close";
  div.appendChild(txt);
  myNodelist[i].appendChild(div);
}

// Click on a close button to hide the current list item
var close = document.getElementsByClassName("close");

for (i = 0; i < close.length; i++) {
  close[i].onclick = function() {
    var id = this.parentElement.getAttribute("id");
    document.getElementById("liDelete").value = document.getElementById(
      id
    ).innerHTML;
    document.getElementById("hidForm").action = "delToDo";
    document.getElementById("hidForm").submit();
  };
}

// Create an "edit" button and append it to each list item
for (i = 0; i < myNodelist.length; i++) {
  var div = document.createElement("Div");
  div.innerHTML = "&#x270E;";
  div.className = "edit";
  div.setAttribute("onclick", "openForm()");
  myNodelist[i].appendChild(div);
}

// Click on an edit button to edit the current list item
var edit = document.getElementsByClassName("edit");

for (i = 0; i < edit.length; i++) {
  edit[i].onclick = function() {
    document.getElementsByClassName("form-popup")[0].style.display = "block";
    var id = this.parentElement.getAttribute("id");
    document.getElementById("liUpd").value = document.getElementById(
      id
    ).innerHTML;
    document.getElementById("hidForm").action = "updToDo";
  };
}

// Create a "star" button and append it to each list item
for (i = 0; i < myNodelist.length; i++) {
  var div = document.createElement("Div");
  div.innerHTML = "&#9734;";
  div.className = "star";
  myNodelist[i].appendChild(div);
}

// Click on a star button to highkigh the current list item
var star = document.getElementsByClassName("star");
for (i = 0; i < star.length; i++) {
  star[i].onclick = function() {
    var id = this.parentElement.getAttribute("id");
    document.getElementById("liDelete").value = document.getElementById(
      id
    ).innerHTML;
    document.getElementById("hidForm").action = "starToDo";
    document.getElementById("hidForm").submit();
  };
}

// Add a "checked" symbol when clicking on a list item
var list = document.querySelector("ul");
list.addEventListener("click", function(ev) {
  if (ev.target.tagName === "LI") {
    ev.target.classList.toggle("checked");
    var id = ev.target.getAttribute("id");
    document.getElementById("liDelete").value = document.getElementById(
      id
    ).innerHTML;
    document.getElementById("hidForm").action = "statusCh";
    document.getElementById("hidForm").submit();
  }
});

function closeForm() {
  document.getElementsByClassName("form-popup")[0].style.display = "none";
}
