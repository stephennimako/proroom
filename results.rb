class Results
  attr_accessor :gross_rent

  def initialize(options)
    @gross_rent = options[:gross_rent]
    @lettings_service_percentage = options[:lettings_service]
    @management_service_percentage = options[:management_service]
    @yearly_maintenance_and_repairs = options[:maintenance_and_repairs]
    @yearly_voids = options[:voids]
    @yearly_additional_fees = options[:additional_fees]
  end

  def lettings_service
    round_to_two_decimals((@lettings_service_percentage / 100) * @gross_rent)
  end

  def management_service
    round_to_two_decimals((@management_service_percentage / 100) * @gross_rent)
  end

  def maintenance_and_repairs
    round_to_two_decimals(@yearly_maintenance_and_repairs / 12)
  end

  def voids
    round_to_two_decimals(@yearly_voids / 12)
  end

  def additional_fees
    round_to_two_decimals(@yearly_additional_fees / 12)
  end

  def total_costs
    round_to_two_decimals(lettings_service + management_service + maintenance_and_repairs + voids + additional_fees)
  end

  def net_rent
    @gross_rent - total_costs
  end

  def round_to_two_decimals(number)
    (number * 100).round / 100.0
  end
end