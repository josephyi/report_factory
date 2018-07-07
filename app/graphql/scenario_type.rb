ScenarioType = GraphQL::ObjectType.define do
  name 'Scenario'
  description 'Test Scenario'
  field :spec_id, !types.String do
    resolve -> (obj, args, ctx) { obj.spec_id }
  end
  field :description, !types.String do
    resolve -> (obj, args, ctx) { obj.description }
  end
  field :full_description, !types.String do
    resolve -> (obj, args, ctx) { obj.full_description }
  end
  field :status, !types.String do
    resolve -> (obj, args, ctx) { obj.status }
  end
  field :line_number, !types.String do
    resolve -> (obj, args, ctx) { obj.line_number }
  end
end
