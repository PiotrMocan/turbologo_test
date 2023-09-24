class Api::TemplatesController < ApplicationController
  def index
    render json: ::Api::Templates::SearchService.new.call(search_params.merge(per_page:, page:))
  end

  private

  def search_params
    params.permit(:industry_id, :company_name, :slogan, icon_ids: [])
  end

  def per_page
    params[:per_page].to_i.positive? ? params[:per_page] : 100
  end

  def page
    params[:page].to_i.positive? ? params[:page] : 1
  end
end
