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
