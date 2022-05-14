// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// import 'bootstrap' working

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()

require("@popperjs/core")

import * as bootstrap from 'bootstrap';
import { Tooltip, Popover } from "bootstrap"

// import "@fortawesome/fontawesome-free/css/all.css";
// import "@fortawesome/fontawesome-free/css/solid.css";

require("../stylesheets/application.scss")
import "@fortawesome/fontawesome-free/js/all";
import "@fortawesome/fontawesome-free/css/all";
require("packs/jquery.easy-autocomplete")


import "./jquery";
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)


let inpFile;
let previewContainer;
let previewImage;
let previewImageClose;
let file;
let check;
 
$( document ).on('turbolinks:load', function() {

    // SET VH VARIABLE
    let vh = window.innerHeight * 0.01;
    
    document.documentElement.style.setProperty('--vh', `${vh}px`);

    window.addEventListener('resize', () => {
      
      let vh = window.innerHeight * 0.01;
      document.documentElement.style.setProperty('--vh', `${vh}px`);

    });

    // NOTIFICATIONS FETCH
    if ($('#Notificationmenu').length && !$('#Notificationmenu').hasClass('disabled')) {

        //clear notifications (mark_as_read)
        var notifications = $("[data-behavior='notifications']");

        $("[data-behavior='notifications-link']").on("click", function(){
            
            $.ajax({
                url: "/notifications/mark_as_read",
                dataType: "JSON",
                method: "POST",
                success: function(){
                    $("[data-behavior='unread']").css({opacity: 0})
                }
            })

        })

        //check for notifications 
        $.ajax({
            url: "/notifications.json",
            dataType: "JSON",
            method: "GET",
            success: function(data){
                
                var items = data.map( function(notification) {
                    var pimg;
                    if (notification.actorimg == undefined || notification.actorimg == null){
                        pimg = ""
                    }else{
                        pimg = "<img class='notification-actor me-1' src='" + notification.actorimg + "'>"
                    }

                    if (notification.action == "messaged"){
                        return "<li class='dropdown-item'><a data-notifiable-id=" + notification.notifiable_id + " href='" + notification.url + "'>" + pimg + " " + "<span>" + "@" + notification.actor + " " + notification.action + " " + "you" + "</span>" +  "</a></li>";
                    }else{
                        return "<li class='dropdown-item'><a data-notifiable-id=" + notification.notifiable_id + " href='" + notification.url + "'>" + pimg + " " + "<span>" + "@" + notification.actor + " " + notification.action + " " + notification.notifiable.type + "</span>" +  "</a></li>";
                    }
                })

                if(items.length != 0){
                    $("[data-behavior='unread']").css({opacity: 1});

                    $("[data-behavior='notification-items']").append(items);
                }else{
                
                    $('.notification-menu').append('<li class="dropdown-item text-center pe-none p-2">There\'s nothing here</li>');

                }

            }
        })


    } 
    

    //***//

    //scrolling reaction icons
    // $(".app-container").on("wheel", ".react-wr", function(e) {
    //     e = window.event || e;
    //     var delta = Math.max(-1, Math.min(1, (e.wheelDelta || -e.detail)));
    //     this.scrollLeft -= (delta * 40); // Multiplied by 40
    //     e.preventDefault();
    // })

    //***//

    // notice fade
    setTimeout(function() {
        $('#notice_wrapper div').fadeOut("slow", function() {
            $(this).remove();
        })
    }, 5000)

    // alert fade
    setTimeout(function() {
        $('#alert_wrapper div').fadeOut("slow", function() {
            $(this).remove();
        })
    }, 5000)

    //img preview
    const imgPreview = function(){
    
        file = this.files[0];

        if(file) {
            const reader = new FileReader()

            previewImage.style.display = "block";
            previewImageClose.style.display = "block";
            previewContainer.style.display = "block";

            reader.addEventListener("load", function() {
                previewImage.setAttribute("src", this.result);
                // 
                previewImage.classList.add("pr-img");

            })

            reader.readAsDataURL(file);
        } else {
            previewContainer.style.display = null;
            previewImage.style.display = null;
            previewImageClose.style.display = null;
            previewImage.setAttribute("src", "");
        }
            
        
    };

    //remove image
    const clearImg = function(){
        
        document.getElementById('inpFile').value = "";
        previewContainer.style.display = null;
        previewImage.style.display = null;
        previewImageClose.style.display = null;
        previewImage.setAttribute("src", "");
       
    };

    //addEventListener if image with close btn exist
    if(document.querySelector('.imgclose')){
        
        document.querySelector('.imgclose').addEventListener("click", clearImg, false);

    }
    
    //***//

    //MODAL
    if ($("#postModal").length) {

        // post modal
        const postModal = document.getElementById('postModal');

        postModal.addEventListener('show.bs.modal', function (e) {

            if (e.relatedTarget.getAttribute("data-istype") == "confirmation") {
                
                postModal.querySelector('.modal-dialog').classList.add("modal-sm");
                
            }

        })

        postModal.addEventListener('shown.bs.modal', function (event) {
            
            const modalInstance = bootstrap.Modal.getInstance(event.target);
            const modalForm = $(this).find('form');

            // type confirmation
            if (event.relatedTarget.getAttribute("data-istype") == "confirmation") {
                
                modalInstance._config.backdrop = "static";

                $(this).find('.confirm_continue').on("ajax:success", () => {

                    modalInstance.hide(); 
                    
                }).on("ajax:error", () => {
                    console.log("There was an error.");
                });

            } else {

                modalInstance._config.backdrop = true;

            }

            $(this).find('#post_content').focus();

            //addEventListener for image preview
            if(document.getElementById("new_post")){
                inpFile = document.getElementById("inpFile");
                previewContainer = document.getElementById("imagePreview");
                previewImage = document.querySelector(".image-preview_image");
                previewImageClose = document.querySelector(".edit-img-btn-wr");
                
                document.getElementById("inpFile").addEventListener("change", imgPreview, false);
                document.querySelector('.edit-img-btn-wr').addEventListener("click", clearImg, false);
            }

            modalForm.on('input', '#post_content', (event) => {
                let postcontentval = event.target.value;
                
                if (postcontentval.trim() == '') {
                    $(this).find('.post-btn').prop('disabled', true)
                }else{
                    $(this).find('.post-btn').prop('disabled', false)
                }

                event.currentTarget.style.height = "auto";
                event.currentTarget.style.height = (event.currentTarget.scrollHeight) + "px";

            });

            // close modal after ajax success
            modalForm.on("ajax:success", () => {
                
                modalInstance.hide(); 
                
            }).on("ajax:error", (event) => {
                var detail = event.detail;
                var data = detail[0], status = detail[1],  xhr = detail[2];
                console.log("There was an error.");
                console.log("Error: ", detail);
                console.log("Data: ", data);

            });
             
        })

        postModal.addEventListener('hidden.bs.modal', function (event) {

            const modContent = $(event.currentTarget).find('.modal-post-content');
            
            modContent.html("");

            if (postModal.querySelector('.modal-dialog').classList.contains("modal-sm")) {
                
                postModal.querySelector('.modal-dialog').classList.remove("modal-sm");
                
            } 


        })


        // IMAGE MODAL
        const imModal = document.getElementById('imgModal')

        imModal.addEventListener('show.bs.modal', function (event) {
          // Button that triggered the modal
          const button = event.relatedTarget
          // Extract info from data-bs-* attributes
          const imgurl = button.getAttribute('data-bs-url')

          $(this).find('#ImgM').attr("src", imgurl);

        })

        imModal.addEventListener('hidden.bs.modal', function (event) {
          
          $(this).find('#ImgM').attr("src", '');

        })

    }

    // OFFCANVAS
    if ($("#offcanvasMobile").length) {
       
        const profCanv = document.getElementById('offcanvasMobile')
        const bsOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(profCanv)

        profCanv.addEventListener('show.bs.offcanvas', function (event) {
            
            const btnParent = $(event.relatedTarget).parent();
            
            const modalBodyInput = profCanv.querySelector('.offcanvas-body');

            if ($(event.relatedTarget).hasClass('of-pr-men')) {

                const profDropMenu = btnParent.find(".profile-dropdown");
                profDropMenu.clone(true, true).contents().appendTo(modalBodyInput).end();

            } else {
                
                const dropMenu = btnParent.find(".post-dropdown");
                dropMenu.clone(true, true).contents().appendTo(modalBodyInput).end();
            }

            $('#offcanvasMobile').on("click", "a", function(){
                bsOffcanvas.hide(profCanv);
            })

             $('#offcanvasMobile').on("click", ".confirm-modal", function(){
                bsOffcanvas.hide(profCanv);
            })

        })

        profCanv.addEventListener('hidden.bs.offcanvas', function (event) {
          
            var modalBodyInput = profCanv.querySelector('.offcanvas-body');

            modalBodyInput.innerHTML = "";
        })

    }

    // NOTIFICATION DROPDOWN (disable scroll)
    $('#mobile-nav').on('click', '.mdrop', function() {
        $(this).on('show.bs.dropdown', function () {
            $("body").addClass("dropdown-open");
        }).on('hide.bs.dropdown', function (){
            $("body").removeClass("dropdown-open")
        });    
    })
    
    // POST DROPDOWN (disable scroll desktop)
    $('.app-container').on('click', '.pdrop-btn', function (e) {
        
        const pdropd = bootstrap.Dropdown.getInstance(e.currentTarget);

        if ($(this).hasClass("show")) {

            $("body").addClass("dropdown-open");
            $('<div class="modal-backdrop fade post-backdrop"></div>').appendTo(document.body);
            
        }

        this.addEventListener("hide.bs.dropdown", function hidePostMenu(){
         
            $("body").removeClass("dropdown-open")
            $(".modal-backdrop.post-backdrop").remove();
            
            this.removeEventListener("hide.bs.dropdown", hidePostMenu)

        });

    })


    // PROFILE POPOVER
    $('.app-container').on('mouseenter', '[data-bs-toggle="popover-prof"]', function(){  

        const _this = this;
        // const allowOpt = bootstrap.Tooltip.Default.allowList;
        // const popform = $('.popover').find('.pop-message')
        

        // allowOpt.a = ['data-bs-target', 'data-bs-toggle', 'data-remote', 'data-method', 'href'];
        // allowOpt.button = ['type', 'action', 'method'];
        // allowOpt.form = ['data-remote', 'method', 'action', 'data-type', 'type'];
        // allowOpt.input = ['hidden', 'name', 'value', 'type', 'data-type'];

        const _profpopover = new bootstrap.Popover(_this, {
            html: true,
            sanitize: false
        })
        
        _profpopover.show();
       
        // hide popover mouseleave (img) || click img
        $(_this).on('mouseleave', function() {
            setTimeout(function() {
              if (!$(".popover:hover").length) {
                _profpopover.hide();
              }
            }, 300);
        }).on('click', function() {
            _profpopover.dispose();
        })

        // hide popover new conversation (call modal)
        $(".popmsg.popnewmsg").on("click", function(e){
            
            $('body').find('#' + _profpopover.tip.id).css("z-index", "1");

        })

        // hide popover existing conversation
        $(".popmsg.popconv").on("click", function(){
            // _profpopover.dispose();
        })

        // hide popover mouseleave (popover)
        $('.popover').on("mouseleave", function() {
          _profpopover.hide();
        });

        // hide popover profile link clicked
        $('.popover .popimg a').on("click", function() {
            _profpopover.dispose();
        });
       
    });


    // REACTION DROPDOWN
    $('.app-container').on('click', '.react-dropd', function(e){
        const _this = $(this);
        const _reacPar = $(this).parent().find(".reaction-wrapper");
        const _reacMenu = _reacPar.find(".reaction-menu");

        const rdropd = bootstrap.Dropdown.getOrCreateInstance(e.currentTarget);
        // var rdropd = new bootstrap.Dropdown(e.currentTarget)

        function reactScroll (e) {
            e = window.event || e;
            var delta = Math.max(-1, Math.min(1, (e.wheelDelta || -e.detail)));
            this.scrollLeft -= (delta * 40); // Multiplied by 40
            e.preventDefault();
        }

     
        _reacPar.on("wheel", reactScroll);
        
        if (_reacPar.hasClass("show")) {
            _reacMenu.children("div").addClass("r-m-show");
        }

        _this.on('mouseleave', function(event) {
            setTimeout(function() {
                if (!$(".reaction-wrapper:hover").length) {
                    rdropd.hide();
                    rdropd.dispose();
                }
              
            }, 2000);
        })

        _reacPar.on("mouseleave", function(event) {
            rdropd.hide();
            rdropd.dispose();
        });

        this.addEventListener('hide.bs.dropdown', function() {
            _reacMenu.children("div").removeClass("r-m-show");
            _this.off('mouseleave');
            _reacPar.off('mouseleave');
            _reacPar.off('wheel');
            _reacPar.scrollLeft(0);
        })

    });

    // CONVERSATION DESTROY
    $("#conversation-wrapper").on("click", "[data-behavior='convset']", function(){
        const cthis = $(this)
        const cw = $(this).closest('.cp-wr');
        const cp = cw.find('.cp');
        const cdbtn = cw.find('.cpdel-c')
        
        if (cp.hasClass('visible')){

            cp.animate({"left":"0px"}, "slow");
            cp.removeClass('visible');

        } else {

            cp.animate({"left":"-55px"}, "slow");
            cp.addClass('visible');

            cw.on('mouseleave', '.cpdel-c', function(cthis){
                cp.animate({"left":"0px"}, "slow");
                cp.removeClass('visible');
                
            })
            
        }
        
    })

    // PAGINATION
    $("body").on('click', '.pagination-more', function(e) {
        e.preventDefault()

        var pageurl = $(this).attr('href')

        $(this).addClass('disabled').removeAttr('href').html("<div class='pagination-loading'><i class='fa fa-spinner fa-spin'></i> <span>Loading...</span></div>");
        $.getScript(pageurl);
    })

    // SANITIZE CONTENT PASTED INTO CHAT
    if ($('[contenteditable]')[0]) {
        var conteditable = document.querySelector('[contenteditable]')
   
        conteditable.addEventListener('paste', function (e) {
          e.preventDefault();
          var text = e.clipboardData.getData('text/plain');
          document.execCommand('insertText', false, text);
        });

    }

    // SEARCH AUTOCOMPLETE
    var $input = $("[data-behavior='autocomplete']")

    var options = {
        // getValue: "name",

        getValue: function(element) {
            
            if(element.img === null){
                element.img = "https://trummi-bucket.s3.amazonaws.com/uploads/profile/image1/8/profile.svg"
            }
            if(!element.img){
                element.img = "https://trummi-bucket.s3.amazonaws.com/uploads/profile/image2/8/tag.svg"
            }
            
            if (element.name){
                return element.name
            } else {
                return element.username
            }
            
        },
        template: {
            type: "iconLeft",
            fields: {
                iconSrc: "img"
            }
        },
        url: function(phrase) {
            return "/search.json?q=" + phrase;
        },
        categories: [
            {
                listLocation: "tags",
                header: "<strong>Tags</strong>"
            },
            {
                listLocation: "profiles",
                header: "<strong>Profiles</strong>"
            }
        ],
        list: {
            onChooseEvent: function() {
                var url = $input.getSelectedItemData().url
                $input.val("")
                Turbolinks.visit(url)
            }
        }
    }

    $input.easyAutocomplete(options);

    // SETTINGS VIEW (update profile **checkbox**) 
    $('#settings-form input[type=checkbox]').change(function(){
        
         $("#privateSub").click();
        
    })
    
})