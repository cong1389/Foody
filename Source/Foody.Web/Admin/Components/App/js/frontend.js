$(document).ready(function() { 
	ControllMenuLeft();
	
	// quan ly menu
	ControllAccep();
	
	// hàm điều khiển tổng quát seo
	ControllTabSeoGeneral();
	
	ClickEditMenu();
}); // end ready
	
	// 
	function ControllMenuLeft(){
		var obj_parent = $(".block-menu-icon .icon-parent");
		var obj_active = $(".block-menu-icon .child-0");
		
		var obj_child_parent = $(".block-menu-icon .title-parent");
		var obj_child_1_active  = $(".child-1");
		
		var obj_tru = $(".icon-parent > .plug");
		var obj_tru_child = $(".title-parent > .plug");
		obj_parent.click(function(){
			// phần từ vừa click
			var obj_this = $(this);
			// lấy phần tử kế tiếp
			var obj_all = $(this).next();
			// kiểm tra nếu là child-0
			if(obj_all.hasClass("child-0")){
				var obj_show = $(this).next();
				if(obj_show.hasClass("show-cur")){
					obj_show.slideUp(200);
					obj_show.removeClass("show-cur");
					// đóng tất cả các div child-1
					obj_child_1_active.removeClass("child-content")
					.slideUp(200); 
					// thay đổi thành dấu cộng
					obj_this.find(".plug").attr("src","/Admin/Images/plus.png");
					// đổi thành dấu cộng
					obj_tru_child.attr("src","/Admin/Images/plus.png");
				}else{
					obj_active.removeClass("show-cur")
					.slideUp(200); 
					obj_show.slideDown(300).addClass("show-cur");
					// đổi thành dấu cộng
					obj_tru.attr("src","/Admin/Images/plus.png");
					// thay đổi thành dấu trừ
					obj_this.find(".plug").attr("src","/Admin/Images/minus.png");
					// đóng tất cả các div child-1
					obj_child_1_active.removeClass("child-content")
					.slideUp(200); 
					// đổi thành dấu cộng
					obj_tru_child.attr("src","/Admin/Images/plus.png");
				}
			}// end if
		});
		
		var obj_tru_child = $(".title-parent > .plug");
		obj_child_parent.click(function(){
			var obj_this_child = $(this);
			var obj_child_1 = $(this).next();
			if(obj_child_1.hasClass("child-content")){
				obj_child_1.slideUp(200);
				obj_child_1.removeClass("child-content");
				// thay đổi thành dấu cộng
					obj_this_child.find(".plug").attr("src","/Admin/Images/plus.png");
			}else{
				obj_child_1_active.removeClass("child-content")
					.slideUp(200); 
				obj_child_1.slideDown(300)
				.addClass("child-content");
				// đổi thành dấu cộng
					obj_tru_child.attr("src","/Admin/Images/plus.png");
				// thay đổi thành dấu trừ
					obj_this_child.find(".plug").attr("src","/Admin/Images/minus.png");
			}
			
		});
	}
	
	// controll tab 
	function ControllTabSeoGeneral(){
		var obj_tab = $(".tab-click");
		var form_list = $(".form-list");
		obj_tab.click(function(){
			obj_tab.removeClass("active-tab");
			var obj_id = $(this).attr("id");
			$(this).addClass("active-tab");
			
			// xóa class form-act tất cả các form
			form_list.removeClass("form-act");
			// chọn đối tượng form có tên trùng với id của tab điều khiển
			$("." + obj_id).addClass("form-act");
		});
	}
	
	// quan ly menu
	function ControllAccep(){
		var obj_img_def = $("img.status-kd-df");
		var obj_img_del = $("img.dele-df");
		// dat hinh mac dinh
		obj_img_def.attr("src","/Admin/Images/circle.png");
		// khi click
		obj_img_def.click(function(){
			// khi dang la default
			if($(this).hasClass("status-kd-df")){
				$(this).removeClass("status-kd-df")
				.attr("src","/Admin/Images/circle_ac.png");
				$(this).parent().next().next()
				.find("img")
				.attr("src","/Admin/Images/close_ac.png");
			}else{
				$(this).attr("src","/Admin/Images/circle.png")
				.addClass("status-kd-df");
				$(this).parent().next().next()
				.find("img")
				.attr("src", "/Admin/Images/close.png");
			}
		}); // end click
		
		// on click edit
		var obj_icon_edit = $(".icon-edit-menu");
		var p_first = $(".block-cantain-tab p");
		obj_icon_edit.click(function(){
			var title_tab = $(this).closest("tr").find(".menu-code").html()
			p_first.attr("title",title_tab);
		});// end click
	}
	
	// Click edit menu
	function ClickEditMenu(){
		var obj_icon = $(".item-tab-menu p, .close-form");
		var obj_form = $(".item-form-menu");
		obj_icon.click(function(){
			if($(this).hasClass("item-form-menu-ac")){
				$(this).removeClass("item-form-menu-ac");
				$(this).next().slideUp(350);
			}else{
				obj_icon.removeClass("item-form-menu-ac");
				obj_form.slideUp(200).find("button.reset-form").click();
				$(this).addClass("item-form-menu-ac");
				$(this).next().slideDown(350);
			}
		});
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	