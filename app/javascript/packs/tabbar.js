// $(document).on('turbolinks:load', function() {
  $(document).ready(function () {

    // class="tab"であり、id="tab1"ではない要素を非表示にする。
    // $('#tab-contents .tab[id != "tab1"]').hide();
    // $('#tab-contents .tab').hide();
    // $('.nav-tabs .active').attr("href").show();

    // $('.nav-tabs a').on('click', function(event){
    //   $("#tab-contents .tab").hide();
    //   $(".nav-tabs .active").removeClass("active");
    //   $(this).addClass("active");
    //   $($(this).attr("href")).show();
    //   event.preventDefault();
    // });


    $('#tab-contents .tab[id != "tab1"]').hide();

    $('#tab-menu a').on('click', function(event) {
      $("#tab-contents .tab").hide();
      $("#tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });


  });
// });