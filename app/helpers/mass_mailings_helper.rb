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

  def mass_mailing_badge(mass_mailing)
    case mass_mailing.status
    when 'success'
      'glyphicon glyphicon-ok-sign'
    when 'warning'
      'glyphicon glyphicon-info-sign'
    when 'in_progress'
      'glyphicon glyphicon-refresh'
    when 'failed'
      'glyphicon glyphicon-remove-sign'
    else
      'glyphicon glyphicon-question-sign'
    end
  end
end
