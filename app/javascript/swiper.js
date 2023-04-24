// Swiperのオプションを定数化
const opt = {
  loop: true,
  autoplay: {
    delay: 3000,
  },
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
  speed: 1000
}

// Swiperを実行(初期化)
// $(document).on('turbolinks:load', function() {
$(document).ready(function () {
  let swiper = new Swiper('.swiper',opt);
});
// });

