let filterID = 1;
function addFilterRow() {
    const filterContainer = document.getElementById("filterContainer");
    const newFilterRow = document.createElement("div");
    newFilterRow.classList.add("row", "g-3", "search-row");

    newFilterRow.innerHTML = `
        <div class="col-md-3 d-flex flex-column">
            <div class="d-flex gap-2 filter-row">
                <button class="btn btn-outline-danger remove-filter-btn" type="button" title="Remove Filter Field" onclick="removeFilterRow(this)">
                    <i class="bi bi-dash-lg"></i>
                </button>
                <select class="form-select searchField" name="type" id="filterType${filterID}">
                    <option value="all">Search All</option>
                    <option value="EmployeeID">Employee ID</option>
                    <option value="Name">Name</option>
                    <option value="RoleName">Role</option>
                    <option value="hotelName">Hotel Branch</option>
                    <option value="Mail">Mail</option>
                    <option value="PhoneNum">PhoneNum</option>
                    <option value="StatusName">Status</option>
                    <option value="Salary">Salary</option>
               </select>
           </div>
        </div>
<!--        <div class="col-md-9">-->
<!--            <div class="input-group">-->
<!--                <input type="text" class="form-control" placeholder="Search employees...">-->
<!--                <button class="btn btn-outline-secondary" type="button">-->
<!--                    <i class="bi bi-search"></i>-->
<!--                </button>-->
<!--            </div>-->
<!--        </div>--> 
 


    `;

    filterID++;
    filterContainer.appendChild(newFilterRow);
}

function removeFilterRow(button) {
    button.parentElement.parentElement.parentElement.remove();
}

function dynamicFilter() {
    document.getElementById("hotelFilter").classList.add("hidden");
    document.getElementById("typeFilter").classList.add("hidden");
    document.getElementById("roomFilter").classList.add("hidden");
    document.getElementById("priceFilter").classList.add("hidden");

    document.getElementById("hotelFilter").classList.remove("show-up");
    document.getElementById("typeFilter").classList.remove("show-up");
    document.getElementById("roomFilter").classList.remove("show-up");
    document.getElementById("priceFilter").classList.remove("show-up");


    const filterType = document.getElementById('filterType').value;
    // Show the selected filter field
    if (filterType === "hotel") {
        const hotelFilter = document.getElementById('hotelFilter');
        // hotelFilter.style.display = "block";
        hotelFilter.classList.remove('hidden');
        hotelFilter.classList.add('show-up');
    } else if (filterType === "type") {
        const typeFilter = document.getElementById('typeFilter');
        typeFilter.classList.remove('hidden');
        typeFilter.classList.add('show-up');
    } else if (filterType === "room") {
        const roomFilter = document.getElementById('roomFilter');
        roomFilter.classList.remove('hidden');
        roomFilter.classList.add('show-up');
    } else if (filterType === "price") {
        const priceFilter = document.getElementById('priceFilter');
        priceFilter.classList.remove('hidden');
        priceFilter.classList.add('show-up-price');
    }
}
