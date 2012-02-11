# encoding: utf-8

class ApplicationDecorator < Draper::Base
  delegate :to_s, to: :model
end
