json.message "success"
json.success true

json.data do

  json.content @page_content.content rescue nil
  json.type @page_content.page_type rescue nil

end