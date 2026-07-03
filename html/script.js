const app = document.getElementById('app');
const searchInput = document.getElementById('search');
const categoryList = document.getElementById('category-list');
const vehicleGrid = document.getElementById('vehicle-grid');
const emptyState = document.getElementById('empty-state');
const currentCategoryEl = document.getElementById('current-category');
const resultCountEl = document.getElementById('result-count');
const badgeAllEl = document.getElementById('badge-all');
const btnClose = document.getElementById('btn-close');
const btnAllVehicles = document.getElementById('btn-all-vehicles');
const labelAllVehicles = document.getElementById('label-all-vehicles');
const uiSubtitle = document.getElementById('ui-subtitle');

let categories = [];
let allVehicles = [];
let activeCategory = 'all';
let searchQuery = '';
let locale = {};

function getResourceName() {
    return window.GetParentResourceName ? window.GetParentResourceName() : 'gabz-vehicle-spawner';
}

function postNui(event, data = {}) {
    return fetch(`https://${getResourceName()}/${event}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
    });
}

function t(path, ...args) {
    const keys = path.split('.');
    let value = locale;

    for (const key of keys) {
        if (!value || typeof value !== 'object') {
            return path;
        }
        value = value[key];
    }

    if (typeof value !== 'string') {
        return path;
    }

    if (args.length > 0) {
        return value.replace(/%[sd]/g, () => args.shift());
    }

    return value;
}

function getCategoryLabel(categoryKey) {
    if (locale.categories && locale.categories[categoryKey]) {
        return locale.categories[categoryKey];
    }

    const category = categories.find((cat) => cat.key === categoryKey);
    return category ? category.name : categoryKey;
}

function applyLocale() {
    const ui = locale.ui || {};

    document.getElementById('ui-title').textContent = ui.title || 'GabZ Vehicle Spawner';
    uiSubtitle.textContent = (ui.subtitle || 'GabZ Vehicle Pack · %d vehicles').replace('%d', allVehicles.length);
    document.getElementById('search').placeholder = ui.search_placeholder || 'Search...';
    document.getElementById('empty-state-text').textContent = ui.no_vehicles_found || 'No vehicles found.';
    document.getElementById('footer-spawn').textContent = ui.footer_spawn || 'Enter / Click to spawn';
    document.getElementById('footer-close').textContent = ui.footer_close || 'ESC to close';
    btnClose.title = ui.close_tooltip || 'Close';
    labelAllVehicles.textContent = ui.all_vehicles || 'All Vehicles';

    document.documentElement.lang = window.__menuLang || 'en';
}

function flattenVehicles(cats) {
    const vehicles = [];
    cats.forEach((cat) => {
        cat.vehicles.forEach((vehicle) => {
            vehicles.push(vehicle);
        });
    });
    return vehicles;
}

function renderCategoryButtons() {
    categoryList.innerHTML = '';

    categories.forEach((category) => {
        const button = document.createElement('button');
        button.className = 'category-btn';
        button.dataset.category = category.key;
        button.innerHTML = `
            ${category.name}
            <span class="badge">${category.vehicles.length}</span>
        `;

        button.addEventListener('click', () => {
            setActiveCategory(category.key);
        });

        categoryList.appendChild(button);
    });
}

function setActiveCategory(category) {
    activeCategory = category;

    document.querySelectorAll('.category-btn').forEach((btn) => {
        btn.classList.toggle('active', btn.dataset.category === category);
    });

    renderVehicles();
}

btnAllVehicles.addEventListener('click', () => {
    setActiveCategory('all');
});

function getFilteredVehicles() {
    let vehicles = allVehicles;

    if (activeCategory !== 'all') {
        vehicles = vehicles.filter((v) => v.category === activeCategory);
    }

    if (searchQuery.trim()) {
        const query = searchQuery.toLowerCase().trim();
        vehicles = vehicles.filter((v) => {
            return (
                v.name.toLowerCase().includes(query) ||
                v.brand.toLowerCase().includes(query) ||
                v.model.toLowerCase().includes(query) ||
                v.category.toLowerCase().includes(query) ||
                (v.categoryLabel && v.categoryLabel.toLowerCase().includes(query))
            );
        });
    }

    return vehicles;
}

function formatResultCount(count) {
    const key = count === 1 ? 'ui.results_one' : 'ui.results_other';
    return t(key, count);
}

function renderVehicles() {
    const vehicles = getFilteredVehicles();

    if (activeCategory === 'all') {
        currentCategoryEl.textContent = t('ui.all_vehicles');
    } else {
        currentCategoryEl.textContent = getCategoryLabel(activeCategory);
    }

    resultCountEl.textContent = formatResultCount(vehicles.length);
    vehicleGrid.innerHTML = '';

    if (vehicles.length === 0) {
        emptyState.classList.remove('hidden');
        vehicleGrid.classList.add('hidden');
        return;
    }

    emptyState.classList.add('hidden');
    vehicleGrid.classList.remove('hidden');

    vehicles.forEach((vehicle) => {
        const card = document.createElement('div');
        card.className = 'vehicle-card';
        card.innerHTML = `
            <span class="category-tag">${vehicle.categoryLabel || getCategoryLabel(vehicle.category)}</span>
            <div class="brand">${vehicle.brand}</div>
            <div class="name">${vehicle.name}</div>
            <span class="model">${vehicle.model}</span>
        `;

        card.addEventListener('click', () => {
            spawnVehicle(vehicle.model);
        });

        vehicleGrid.appendChild(card);
    });
}

function spawnVehicle(model) {
    postNui('spawn', { model });
}

function openMenu(data) {
    locale = data.locale || {};
    window.__menuLang = data.lang || 'en';
    categories = data.categories || [];
    allVehicles = flattenVehicles(categories);
    activeCategory = 'all';
    searchQuery = '';

    applyLocale();

    searchInput.value = '';
    badgeAllEl.textContent = allVehicles.length;

    document.querySelectorAll('.category-btn').forEach((btn) => {
        btn.classList.toggle('active', btn.dataset.category === 'all');
    });

    renderCategoryButtons();
    renderVehicles();

    app.classList.remove('hidden');
    searchInput.focus();
}

function closeMenu() {
    app.classList.add('hidden');
    postNui('close');
}

btnClose.addEventListener('click', closeMenu);

searchInput.addEventListener('input', (e) => {
    searchQuery = e.target.value;
    renderVehicles();
});

document.addEventListener('keydown', (e) => {
    if (app.classList.contains('hidden')) return;

    if (e.key === 'Escape') {
        closeMenu();
    }
});

window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.action === 'open') {
        openMenu(data);
    } else if (data.action === 'close') {
        app.classList.add('hidden');
    }
});