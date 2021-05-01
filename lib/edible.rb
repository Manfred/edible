# frozen_string_literal: true

module Edible
  autoload :Builder, 'edible/builder'

  def self.build(**settings, &block)
    out = String.new(capacity: 4096)
    builder = Edible::Builder.new(out, **settings)
    builder.una
    builder.unb

    if block.arity == 0
      builder.instance_eval(&block)
    else
      block.call(builder)
    end

    out
  end
end
