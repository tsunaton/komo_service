class Form::Work < Work
  has_many :machings, class_name: 'Form::Maching'
  accepts_nested_attributes_for :machings
end
