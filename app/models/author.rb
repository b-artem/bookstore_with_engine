class Author < ApplicationRecord
  has_and_belongs_to_many :books

  validates :first_name, :last_name,
            presence: true,
            format: { with: /\A[a-zA-Z]+\z/,
                      message: I18n.t('models.author.names_symbols') },
            length: { maximum: 49 }
end
