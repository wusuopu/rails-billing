class Category
  include Mongoid::Document

  field :name
  field :type, type: Integer, default: 0
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id"
  has_many :children, class_name: "Category", foreign_key: "parent_id"

  module TYPE
    INCOME = 0
    EXPENSE = 1
  end

  index({ name: 1 }, {})

  validates :name, presence: true
  validates_inclusion_of :type, in: [0, 1]

  def type_name
    @type_name ||= I18n.t "category_type_#{type}"
  end
end
