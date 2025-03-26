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

function redirectToServlet(contextPath, servletName) {
    // confirm("go to path " + contextPath + "/" + servletName + "?");
    window.location.href = contextPath + "/" + servletName;
}

function redirect(link, page) {
    // hien danh sach search
    if (link.includes("pageNo=")) {
        window.location.href = link.substring(0, link.indexOf("pageNo=")) + page;
    } else {
        if (link.includes("?")) {
            window.location.href = link + '&' + page;
        } else {
            window.location.href = link + '?' + page;
        }
    }
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

