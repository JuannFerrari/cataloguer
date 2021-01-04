import { Controller } from "stimulus";
import $ from "jquery";

require("select2/dist/css/select2");
require("select2-bootstrap-theme/dist/select2-bootstrap");

import Select2 from "select2";

export default class extends Controller {
  static targets = [ 'contentSearch' ]
  static values = { url: String }

  connect() {
    $(this.contentSearchTarget).select2({
      ajax: {
        url: this.urlValue,
        dataType: "json",
        delay: 300,
        data: function (params) {
          let query = {
            search_term: params.term,
          };
          return query;
        },
        processResults: function (data) {
          return {
            results: data,
          };
        },
      },
    });
  }
}
