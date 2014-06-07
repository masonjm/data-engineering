module ImportsHelper
  def import_status
    case @importer.status
    when :success
      "text-success"
    else
      "text-danger"
    end
  end
end
