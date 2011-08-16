# -*- encoding: utf-8 -*-
require 'rubygems'
require 'active_record'

module PolishValidations
  def validates_as_bank_account(*attr_names)
    configuration = { :on => :save }
    configuration.update(attr_names.extract_options!)

    validates_each(attr_names, configuration) do |record, attr_name, value|
      value.to_s.gsub!(/[^0-9]/,'')
      z = 0
      if value.to_s.length == 26
        n = value + "2521"
        w = [1,10,3,30,9,90,27,76,81,34,49,5,50,15,53,45,62,38,89,17,73,51,25,56,75,71,31,19,93,57]
        x = n[2..-1] + n[0,2]
        (0...30).each { |i| z += x[29-i,1].to_i * w[i] }
      end
      record.errors.add attr_name, :invalid, :default => configuration[:message], :value => value if (z % 97) != 1
    end
  end

  def validates_as_nip(*attr_names)
    configuration = { :on => :save }
    configuration.update(attr_names.extract_options!)

    validates_each(attr_names, configuration) do |record, attr_name, value|
      value.to_s.gsub!(/[^0-9]/,'')
      nip_digits = value.to_s.split('').map(&:to_i)
      unless value.present? && nip_digits.length == 10 &&
          (0..8).inject(0) {|s,i| s += nip_digits[i] * [6,5,7,2,3,4,5,6,7][i] } % 11 == nip_digits.last
        record.errors.add attr_name, :invalid, :default => configuration[:message], :value => value
      end
    end
  end

  def validates_as_regon(*attr_names)
    configuration = { :on => :save }
    configuration.update(attr_names.extract_options!)

    validates_each(attr_names, configuration) do |record, attr_name, value|
      value.to_s.gsub!(/[^0-9]/,'')
      regon_digits = value.split('').map(&:to_i)
      valid = false
      if regon_digits.length == 9
        valid = (0...8).inject(0) {|s,i| s += regon_digits[i] * [8,9,2,3,4,5,6,7][i] } % 11 == regon_digits.last
      elsif regon_digits.length == 14
        valid = (0...13).inject(0) {|s,i| s += regon_digits[i] * [2,4,8,5,0,9,7,3,6,1,2,4,8][i] } % 11 == regon_digits.last
      end
      record.errors.add attr_name, :invalid, :default => configuration[:message], :value => value unless valid
    end
  end
end

ActiveRecord::Base.extend(PolishValidations)