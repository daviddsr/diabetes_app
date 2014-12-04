module ApplicationHelper

	def bootstrap_class_for flash_type
    if flash_type == "success"
        "alert-success"
    elsif flash_type == "error"
        "alert-danger"
    elsif flash_type == "alert"
        "alert-warning"
    elsif flash_type == "notice"
        "alert-info"
    else
        flash_type.to_s
    end
  	end
end
