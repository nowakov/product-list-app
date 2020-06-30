# frozen_string_literal: true

class BaseService
  attr_accessor :output, :errors

  class << self
    def with(args)
      new(args).tap(&:call)
    end

    def context(*args)
      args.each do |arg|
        key, default_value = arg.is_a?(Hash) ? arg.to_a.first : [arg, nil]
        define_method(key) { @context.key?(key) ? @context[key] : default_value }
      end
    end
  end

  def success?
    @errors.empty?
  end

  private

  def initialize(context = {})
    @context = ServiceContext[context]
    @errors = Hash.new({})
    @output = Hash.new({})
  end

  class ServiceContext < HashWithIndifferentAccess; end
end
