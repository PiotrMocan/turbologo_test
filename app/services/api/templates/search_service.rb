module Api
  module Templates
    class SearchService
      TEMPLATE_SELECT = <<~SQL
        templates.id, templates.preview_image,
        SUM(template_stats.sales_count) AS sales_sum,
        SUM(template_stats.impressions_count) AS impressions_sum,
        SUM(template_stats.clicks_count) AS clicks_sum
      SQL

      TEMPLATE_ORDER_BY = <<~SQL
        sales_sum DESC NULLS LAST,
        impressions_sum DESC NULLS LAST,
        clicks_sum DESC NULLS LAST
      SQL

      def call(search_params = {})
        company_name = search_params[:company_name].presence

        return Template.none unless company_name

        industry = Industry.find_by(id: search_params[:industry_id])
        slogan = search_params[:slogan].presence
        is_icon_selected = search_params[:icon_ids].present?
        per_page = search_params[:per_page]
        page = search_params[:page]

        template_scope = Template.left_joins(:template_stats).select(TEMPLATE_SELECT)
        # uses explicit IN to avoid meaningless sanitization
        advanced_metric_scope = AdvancedMetric.select('DISTINCT ON (template_name) template_name')
                                              .where('template_name IN (?)', template_ids_by_company_name(company_name))

        advanced_metric_scope = advanced_metric_scope.where(industry_id: industry.id) if industry

        if is_icon_selected
          advanced_metric_scope = advanced_metric_scope.where(icon_selected: true)
        else
          template_scope = template_scope.where.not(icon_required: true)
        end

        if slogan
          advanced_metric_scope = advanced_metric_scope.where(slogan_exists: true)
        else
          template_scope = template_scope.where.not(slogan_required: true)
        end

        template_scope
          .where('templates.id IN (?)', advanced_metric_scope) # uses explicit IN to avoid meaningless sanitization
          .order(TEMPLATE_ORDER_BY)
          .group('templates.id')
          .limit(per_page)
          .offset((page - 1) * per_page)
      end

      private

      def template_ids_by_company_name(company_name)
        company_name_length = company_name.length

        CompanyLengthMetric.where(
          <<~SQL
            #{company_name_length} BETWEEN min_length AND max_length AND extended = false
            OR (extended AND #{company_name_length} >= min_length)
          SQL
        ).select('DISTINCT ON (template_name) template_name')
      end
    end
  end
end
