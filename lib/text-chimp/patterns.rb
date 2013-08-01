# encoding: utf-8

module TextChimp
  module Patterns
    EMAIL_REGEXP = %r{
        \b # word boundary
        [0-9a-z] # First character
        (?:
          [0-9a-z.+]+ # Middle characters
          [0-9a-z] # Last character
        )? 
        @ # Separating @ character
        [0-9a-z] # Domain name begin
        (?:
          [0-9a-z.-]+ # Domain name middle
          [0-9a-z] # Domain name end
        )?
        \b # word boundary
      }xi # Case insensitive
  end
end
