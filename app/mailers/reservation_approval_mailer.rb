class ReservationApprovalMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_approval_mailer.approved_mail.subject
  #
  def approved_mail(reservation)
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_approval_mailer.rejected_mail.subject
  #
  def rejected_mail(justification)
    @greeting = "Hi"
    @justification = justification

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_approval_mailer.suspended_mail.subject
  #
  def suspended_mail(justification)
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
