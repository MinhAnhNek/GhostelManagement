function showFilter() {
    let filter = document.getElementById("filterContainer");
    if (filter.classList.contains("hidden")) {
        filter.classList.remove("hidden");
        filter.classList.add("show-up");
        // filterBtn.content.innerHTML = "Hide Filter";
    } else {
        filter.classList.remove("show-up");
        filter.classList.add("hidden");
        // filterBtn.content.innerHTML = "Show Filter";
    }

}
// function redirectToSearchServlet(contextPath){
//     window.location.href = contextPath + '/SearchEmployee';
// }
function redirectToSearchServlet(contextPath, servletName) {
    // confirm("go to path " + contextPath + "/" + servletName + "?");
    window.location.href = contextPath + "/" + servletName;
}

function showButtons() {
    let buttons = document.getElementById("buttonBar");
    if (buttons.classList.contains("d-none")) {
        buttons.classList.remove("d-none");
    } else {
        buttons.classList.add("d-none");
    }
}

function enablePrice(id) {
    let price = document.getElementById(id);
    if (price.classList.contains("d-none")) {
        price.classList.remove("d-none");
    } else {
        price.classList.add("d-none");
    }
}
