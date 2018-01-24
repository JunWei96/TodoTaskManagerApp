// Used for ajax feature of pagination, used when user wants to navigate between pages
// pagination
$(function() {
  $(document).on("click", ".pagination a", function() {
    $.get(this.href, null, null, "script");
    return false;
  });
});
