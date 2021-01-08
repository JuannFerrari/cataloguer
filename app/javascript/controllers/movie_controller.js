import {
  Controller,
} from 'stimulus';
import $ from 'jquery';

import Select2 from 'select2';

require('select2/dist/css/select2');
require('select2-bootstrap-theme/dist/select2-bootstrap');

export default class extends Controller {
  static targets = ['contentSearch', 'submit']

  static values = {
    url: String,
  }

  connect() {
    $(this.contentSearchTarget).select2({
      ajax: {
        url: this.urlValue,
        dataType: 'json',
        delay: 300,
        data(params) {
          const input = params.term.split('-');
          const query = {
            search_term: input[0],
            search_year: input[1],
          };
          return query;
        },
        processResults(data) {
          return {
            results: [{
              id: JSON.stringify(data),
              text: data.title,
            }],
          };
        },
      },
      minimumInputLength: 3,
    });

    $(this.contentSearchTarget).on('select2:select', function () {
      const event = new Event('change');
      this.dispatchEvent(event);
    });
  }

  submitForm() {
    this.submitTarget.click();
  }
}