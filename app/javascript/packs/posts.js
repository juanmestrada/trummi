
// if($('#mobile-nav').is(':visible')) {
//     var lastScrollTop = 0;

//     function scrollfunc () {
       
//         var st = window.pageYOffset || document.documentElement.scrollTop;  
//         if (st > lastScrollTop){
//             $('#mobile-nav').css("transform", "translateY(-100%)");
//         } else {
//             $('#mobile-nav').css("transform", "translateY(0%)");
//         }

//         lastScrollTop = st;
        
//     }

//     // throttle function
//     const throttle = function(callback, limit){
//         var waiting = false;                      
//         return function () {                      
//             if (!waiting) {                       
//                 callback.apply(this, arguments);  
//                 waiting = true;                   
//                 setTimeout(function () {          
//                     waiting = false;              
//                 }, limit);
//             }
//         }
//     }

//     var throttled = throttle(scrollfunc, 150)

//     if ($('#posts-container').length) {
//         $(window).scroll(throttled);
//     }
// }

// insert ad after nth child
    
// $(".post-container:nth-child(2n)").after("<div class='post-container ad'>ad here...</div>");