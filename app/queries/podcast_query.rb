class PodcastQuery
  SORTING = {
    title_asc: -> (scope) { scope.order(title: :asc) },
    title_desc: -> (scope) { scope.order(title: :desc) },
    created_asc: -> (scope) { scope.order(created_at: :asc) },
    created_desc: -> (scope) { scope.order(created_at: :desc) },
    price_asc: -> (scope) { scope.order(price: :asc) },
    price_desc: -> (scope) { scope.order(price: :desc) }
  }
  def initialize(relation, params)
    @relation = relation
    @params = params

    @category_name = params[:category_name]
    @category_type = params[:category_type]
    @search = params[:search]
    @category_params = {}
  end

  def call
    scope = make_search
    SORTING[sort_by].call(filtered_by_category(scope))
  end

  private

  attr_reader :relation, :params, :search, :sort_by, :category_name, :category_type, :category_params

  def make_search
    search.nil? ? relation : relation.where("title ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%")
  end
  def filtered_by_category(relation)
    return relation unless category_params
    p category_params
    relation.joins(:categories).where(categories: category_params).distinct
  end

  def category_params
   @category_params.merge!(name: category_name) if category_name
   @category_params.merge!(category_type: category_type) if category_type && category_type_valid?
   @category_params
  end

  def sort_by
    @sort_by ||= SORTING.key?(params[:sort_by].try(:to_sym)) ? params[:sort_by].try(:to_sym) : :created_asc
  end

  def category_type_valid?
    Category.category_types.include?(category_type)
  end
end