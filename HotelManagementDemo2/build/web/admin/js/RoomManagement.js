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

