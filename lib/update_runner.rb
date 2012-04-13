class UpdateRunner

  def self.run_dmv(options = {})
    unless dmv_requirements_met(options)
      options[:street] = strip_non_alphanumeric(options[:street])
      options[:county] = options[:county].upcase
    end

    if Rails.env == "production"
      output_header = "\n~~~~~RUNNING DMV UPDATE~~~~~~~~~\n#{options}\n\n"
      script_output = "python ./lib/dmv_update.py #{options[:driver_license]} #{options[:ssn]} '#{options[:street]}' #{options[:city]} #{options[:zip]} #{options[:county]}"
      return output_header + script_output
    else
      return "PRETENDED TO RUN THE UPDATE."
    end
  end

  def self.run_amazon(options = {})
    script_output = "python ./lib/amazon_update.py #{options[:email]} '#{options[:password]}' '#{options[:full_name]}' '#{options[:address1]}' '#{options[:address2]}' '#{options[:city]}' '#{options[:state]}' #{options[:zip]} '' #{options[:phone_number]}"
    system(script_output)
  end

  def self.dmv_requirements_met(options)
    return false if options[:county] != options[:county].upcase
    return false if options[:street].match(/[^\w\s]/)
    return true
  end

  def self.strip_non_alphanumeric(string)
    string.split(/[^\w\s]/).join("")
  end

end
