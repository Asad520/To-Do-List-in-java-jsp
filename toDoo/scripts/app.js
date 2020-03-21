const switchers = [...document.querySelectorAll(".switcher")];

switchers.forEach(item => {
  item.addEventListener("click", function() {
    switchers.forEach(item => item.parentElement.classList.remove("is-active"));
    this.parentElement.classList.add("is-active");
  });
});

function validateSignup() {
  var pass = document.getElementById("signup-password");
  var cPass = document.getElementById("signup-password-confirm");
  if (pass.value != cPass.value) {
    var incPwd = document.getElementsByClassName("incPass");
    incPwd[0].style.display = "block";
    incPwd[1].style.display = "block";
    return false;
  } else {
    return true;
  }
}

