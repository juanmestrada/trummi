// scroll
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).ready(function(){
	
  	var leftPaddle = $('.leftPaddle');
  	var	rightPaddle = $('.rightPaddle');
	
	// get items dimensions
	var itemsLength = $('.col-pe').length;
	var itemSize = $('.col-pe').outerWidth(true);
	// get some relevant size for the paddle triggering point
	var paddleMargin = 20; 
  
  	// get wrapper width
	var getscrollWrapperSize = function() {
		return $('.info-scroll').outerWidth();
	}

	var menuWrapperSize = getscrollWrapperSize();

	// the wrapper is responsive
	$(window).on('resize', function() {
		menuWrapperSize = getscrollWrapperSize();
	});

  	// size of the visible part of the menu is equal as the wrapper size 
	var menuVisibleSize = menuWrapperSize;

	// get total width of all menu items
	var getMenuSize = function() {
		return itemsLength * itemSize;
	};
	var menuSize = getMenuSize();
	// get how much of menu is invisible
	var menuInvisibleSize = menuSize - menuWrapperSize;

	// get how much have we scrolled to the left
	var getMenuPosition = function() {
		return $('.pe-scroll').scrollLeft();
	};

	var amount = '';

	function scroll() {
		menuInvisibleSize = menuSize - menuWrapperSize;
		// get how much have we scrolled so far
		var menuPosition = getMenuPosition();

		var menuEndOffset = menuInvisibleSize - paddleMargin;

		// show & hide the paddles 
		// depending on scroll position
		if (menuPosition <= paddleMargin) {
			leftPaddle.addClass('hidden');
			rightPaddle.removeClass('hidden');
		} else if (menuPosition < menuEndOffset) {
			// show both paddles in the middle
			leftPaddle.removeClass('hidden');
			rightPaddle.removeClass('hidden');
		} else if (menuPosition >= menuEndOffset) {
			leftPaddle.removeClass('hidden');
			rightPaddle.addClass('hidden');
		}

		$('.pe-scroll').animate({
			scrollLeft: amount
			}, 100, 'linear', function() {
			if (amount != '') {
				scroll();
			}
		});
	}

	rightPaddle.hover(function() {
		amount = '+=55';
		scroll();
	}, function() {
		amount = '';
	});

	leftPaddle.hover(function() {
		amount = '-=55';
		scroll();
	}, function() {
		amount = '';
	});

})

//add or remove profile images
if(document.querySelector(".profile-form")){

 	$('.profile-form').on('change', '.edit-file-input', function(e){
 		var $this = $(this);
 		var $reader = new FileReader();
 		var $currentUploader = $this.closest('.edit-img-wr');
 		var editImgBtn = $currentUploader.find('.edit-img-btn');
 		var imgelem = $currentUploader.find('.edit-img').attr('data-bs-url')
 		var removeInput = $currentUploader.find('.remove_image');
			
		$reader.onload = function (event) {
			$currentUploader.find('.edit-img').attr('src', event.target.result);
			$currentUploader.find('img.edit-img').attr('data-bs-url', event.target.result);
			$currentUploader.find('img.edit-img').data('bs-url', event.target.result);
			editImgBtn.toggleClass("edit-remove edit-add");
		};
		$reader.readAsDataURL(e.target.files[0]);

		if(imgelem != 'undefined'){

			$currentUploader.find('.edit-img').attr('data-bs-target', '#imgModal');
			$currentUploader.find('.edit-img').attr('data-bs-toggle', 'modal');
			removeInput.val('');

			if (!$currentUploader.find('.edit-img').hasClass('pr-img')) {
				$currentUploader.find('.edit-img').addClass('pr-img');
				$currentUploader.find('img.edit-img').attr('data-bs-toggle', 'modal');
			}
		}
 	}).on('click', '.edit-remove', function(){
 			var $this = $(this);
			var imgwrapper = $this.closest('.edit-img-wr');
 			var editImgBtn = imgwrapper.find('.edit-img-btn');
 			var removeInput = imgwrapper.find('.remove_image');
			imgwrapper.find('img.edit-img').attr('data-bs-url', '');
			imgwrapper.find('img.edit-img').attr('data-bs-target', '');
			imgwrapper.find('img.edit-img').attr('data-bs-toggle', '');
			
			imgwrapper.find('.edit-img').attr('src', "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png");
			// $this.val('')
			removeInput.val('1');
			editImgBtn.toggleClass("edit-remove edit-add");
		}).on('click', '.edit-add', function(){
			var $this = $(this);
			var imgwrapper = $this.closest('.edit-img-wr');
 			var editImgBtn = imgwrapper.find('.edit-img-btn');
 			
			imgwrapper.find('.edit-file-input').click();
			
		})

    $(".wo-close").click(function(){
		$(".welcome-overlay").fadeOut(800, () => $(".welcome-overlay").remove());
	});

   
};