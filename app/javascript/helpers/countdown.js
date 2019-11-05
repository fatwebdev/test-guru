const countdown = (() => {
  document.addEventListener('turbolinks:load', function() {
    const el = document.querySelector('[data-remainder-time]');

    if (el) {
      const remainderTime = el.dataset.remainderTime * 1000;

      setInterval(function () {
        const diff = +new Date(remainderTime) - +new Date();

        if (diff <= 0) {
          document.querySelector('form').submit();
        }

        const diffInSec = Math.floor(diff / 1000)
        const result = `${Math.floor(diffInSec / 60)}:${diffInSec % 60}`;
        el.innerHTML = result;
      }, 1000)
    };
  });
})();

export default countdown;