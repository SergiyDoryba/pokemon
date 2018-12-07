class ExportMailer < ApplicationMailer
  layout 'export_mailer'

  def export_data(user_email)
    user = User.where(email: user_email).first
    return unless user&.email

    mail to: user.email,
         subject: 'We prepare to you Pokemons Dump',
         email_attachment: Rails.root.join('public', 'exports', user.email, DateTime.now.in_time_zone.strftime('%Y_%m_%d'), 'pokemons.xls').to_s
  end
end
