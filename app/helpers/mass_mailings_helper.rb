module MassMailingsHelper
  def mass_mailing_status(mass_mailing)
    case mass_mailing.status
    when 'success'
      'success'
    when 'warning'
      'warning'
    when 'in_progress'
      'info'
    when 'failed'
      'danger'
    else
      ''
    end
  end
end
