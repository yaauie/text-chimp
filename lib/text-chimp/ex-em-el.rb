# encoding: utf-8

module TextChimp
  # A hack. Mix into a well-formed XML string
  # to get Grape to not whine about being unable
  # to convert it to xml.
  # Warning: Does not validate.
  module ExEmEl
    def to_xml(options={})
      self.to_s
    end
  end
end
