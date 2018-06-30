class Results
  attr_accessor :gross_rent, :maintenance_and_repairs, :voids, :additional_fees

  def initialize(options)
    @gross_rent = options[:gross_rent]
    @lettings_service_percentage = options[:lettings_service]
    @management_service_percentage = options[:management_service]
    @maintenance_and_repairs = options[:maintenance_and_repairs]
    @voids = options[:voids]
    @additional_fees = options[:additional_fees]
  end

  def lettings_service
    round_to_two_decimals((@lettings_service_percentage / 100) * @gross_rent)
  end

  def management_service
    round_to_two_decimals((@management_service_percentage / 100) * @gross_rent)
  end

  def total_costs
    round_to_two_decimals(lettings_service + management_service + @maintenance_and_repairs + @voids + @additional_fees)
  end

  def net_rent
    @gross_rent - total_costs
  end

  def round_to_two_decimals(number)
    (number * 100).round / 100.0
  end
end