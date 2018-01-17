class Events::EventSearchService
  def initialize(*args)
    @params = args[0] || {}
    @scope = Event
  end

  def search
    search_by_values(:name, operator: 'LIKE', surround: '%')
    search_by_city
    search_by_start_time
    search_by_categories
    @scope.order(start_time: :asc)
  end

  private

  def search_by_values(value, operator: '=', surround: '')
    return if @params[value].blank?
    @scope = @scope.where("events.#{value} #{operator} ?", "#{surround}#{@params[value]}#{surround}")
  end

  def search_by_city
    return if @params[:city].blank?
    @scope = @scope.joins(:city).where('cities.name = ?', @params[:city])
  end

  def search_by_start_time
    return if @params[:start_time].blank?
    @scope = @scope.where('events.start_time > ?', @params[:start_time])
  end

  def search_by_categories
    return if @params[:categories].to_a.reject { |s| s.to_s.strip.empty? }.blank?
    @scope = @scope.joins(:categories).where('categories.id in (?)', @params[:categories])
  end
end
