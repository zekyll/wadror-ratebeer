module ApplicationHelper
  def edit_and_destroy_buttons(item)
    unless current_user.nil?
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-default btn-sm")
      del = link_to('Delete', item, method: :delete,
                    data: {confirm: 'Are you sure?' }, class:"btn btn-default  btn-sm") if current_user.admin
      raw("#{edit} #{del}")
    end
  end

end
