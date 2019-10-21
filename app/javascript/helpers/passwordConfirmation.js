const setStatus = (xs, isValid) => xs.forEach(el => {
  el.classList.remove(isValid ? 'border-danger' : 'border-success');
  el.classList.add(isValid ? 'border-success' : 'border-danger');
});

const MIN_PASSWORD_LENGTH = 6;

class PasswordConfirmationService {
  constructor(elPassword, elPasswordConfirmation) {
    this.state = { elPassword, elPasswordConfirmation };
    elPassword.addEventListener('input', ({target: {value}}) => this.password = value)
    elPasswordConfirmation.addEventListener('input', ({target: {value}}) => this.passwordConfirmation = value)
  }
  validate() {
    const {
      elPassword,
      elPasswordConfirmation,
      password,
      passwordConfirmation,
      dirty
    } = this.state;

    if (dirty) {
      const isValid = (password.length >= MIN_PASSWORD_LENGTH) && (password === passwordConfirmation);
      setStatus([elPassword, elPasswordConfirmation], isValid);
    }
  }
  set password(password) {
    this.state.password = password;
    this.validate();
  }
  set passwordConfirmation(confirmation) {
    this.state.passwordConfirmation = confirmation;
    this.state.dirty = true;
    this.validate();
  }
}

const passwordConfirmation = (() => {
  document.addEventListener('turbolinks:load', function() {
    const elPassword = document.querySelector('#user_password');
    const elPasswordConfirmation = document.querySelector('#user_password_confirmation');

    if (elPassword && elPasswordConfirmation) {
      new PasswordConfirmationService(elPassword, elPasswordConfirmation);
    }
  });
})();

export default passwordConfirmation;