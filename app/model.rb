Model = Class.new(Sequel::Model) do
  plugin :validation_helpers
end

Model.extend(Machinist::Machinable)