class Form::Work < Work
  REGISTRABLE_ATTRIBUTES = %i(place_id client_id)

  has_many :machings, class_name: 'Form::Maching'
end
