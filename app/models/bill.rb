class Bill
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type, type: Integer, default: 0
  field :amount, type: Float, default: 0
  field :title
  field :description
  field :date, type: Date, default: ->{ Date.today }

  belongs_to :category

  validates_inclusion_of :type, in: [0, 1]

  def type_name
    @type_name ||= I18n.t "category_type_#{type}"
  end
end
