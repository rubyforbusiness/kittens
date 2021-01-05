# frozen_string_literal: true

# Rails standard base class for application
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
