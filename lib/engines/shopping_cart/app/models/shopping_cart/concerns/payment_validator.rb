class Concerns::PaymentValidator < ActiveModel::Validator
  def validate(form)
    return false if valid_terms.include? form.valid_until
    form.errors.add(:valid_until, I18n.t('models.payment.invalid_term'))
  end

  private

    def valid_terms
      terms = []
      (0..120).each do |month|
        terms << (Date.today + month.months).strftime('%m/%y')
      end
      terms
    end
end
