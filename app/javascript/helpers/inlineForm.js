const getIdErrorEntity = () => {
  const el = document.querySelector('[data-error-entity-id]');
  return el ? el.dataset.errorEntityId : null;
}

const isEditBtn = el => el.dataset.testAction === 'edit';

const getAssociatedEls = testId => {
  const dataAttr = `data-test-id="${testId}"`;
  return {
    form: document.querySelector(`form[${dataAttr}]`),
    span: document.querySelector(`span[${dataAttr}]`),
    button: document.querySelector(`a[${dataAttr}][data-test-action]`)
  }
}

const isFormVisible = testId => {
  const { form } = getAssociatedEls(testId);
  return form.style.display !== 'none';
}

const setVisibility = (el, show) => el.style.display = show ? '' : 'none';

const setFormVisibility = (testId, show) => {
  const { form, span, button } = getAssociatedEls(testId);
  setVisibility(form, show);
  setVisibility(span, !show);
  changeBtnText(button, show ? 'cancel' : 'edit');
}

const changeBtnText = (el, action) => {
  el.textContent = el.dataset[`${action}Text`];
}

function handleClick(e) {
  const el = e.target;

  if (!isEditBtn(el)) {
    return;
  }

  e.preventDefault();
  const { testId } = el.dataset;

  const isVisible = isFormVisible(testId);
  setFormVisibility(testId, !isVisible);
}

const showFormWithErrors = () => {
  const id = getIdErrorEntity();
  if (!id) {
    return;
  }
  setFormVisibility(id, true);
}

const inlineForm = (() => {
  document.addEventListener('turbolinks:load', function() {
    const el = document.querySelector('[data-inline-edit="title"]');

    if (el) {
      el.addEventListener('click', handleClick);

      showFormWithErrors();
    };
  });
})();

export default inlineForm;