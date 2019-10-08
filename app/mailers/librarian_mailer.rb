class LibrarianMailer < ApplicationMailer
  layout 'mailer'
  def confirm_book(student)
    @student = student

    mail(to: @student.email, subject: "Reminder- Requested library item available for pickup")
  end
end
