// Click on a star button to highkigh the current list item
var grp = document.getElementsByClassName("btnClass");
for (i = 0; i < grp.length; i++) {
  grp[i].onclick = function() {
    document.getElementById("hidField").value = this.innerHTML;
    document.getElementById("frm").action = "grpList.jsp";
    document.getElementById("frm").submit();
  };
}
