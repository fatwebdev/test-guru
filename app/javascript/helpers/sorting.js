const compareRowsAsc = (row1, row2) => {
  const title1 = row1.querySelector('td').textContent;
  const title2 = row2.querySelector('td').textContent;

  if (title1 === title2) {
    return 0;
  }

  return title1 > title2 ? 1 : -1;
};

const compareRowsDesc = (row1, row2) => compareRowsAsc(row1, row2) * -1

const ORDER_BY_ASC = 'asc'
const ORDER_BY_DESC = 'desc'

function sortRowsByTitle() {
  const table = this.parentNode.parentNode.parentNode;
  const tbody = table.querySelector('tbody');
  const newTbody = document.createElement('tbody');
  const rows = Array.prototype.slice.call(tbody.children);
  const currentOrder = this.dataset.sortOrder || ORDER_BY_DESC;
  const sortStrategy = currentOrder === ORDER_BY_DESC ? compareRowsAsc : compareRowsDesc;

  const sortedRows = rows.sort(sortStrategy);
  sortedRows.forEach(i => newTbody.appendChild(i));

  table.replaceChild(newTbody, tbody);
  this.dataset.sortOrder = currentOrder === ORDER_BY_DESC ? ORDER_BY_ASC : ORDER_BY_DESC;
}

const sort = (() => {
  document.addEventListener('turbolinks:load', function() {
    const el = document.querySelector('[data-sort-by="title"]');

    if (el) {
      el.addEventListener('click', sortRowsByTitle)
    };
  });
})();

export default sort;