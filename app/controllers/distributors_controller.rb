class DistributorsController < ApplicationController
  before_action :set_distributor, only: [:show, :update, :destroy]
 # before_action :authenticate_retailer!, only: [:distributors_by_retailer]
 # before_action :authenticate_distributor!, except: [:distributors_by_retailer]
  # GET /distributors
  def index
    @distributors = Distributor.load_distributors(params[:page], params[:per_page])
    render json: @distributors, root: "data", adapter: :json,render_attribute: params[:select_distributor] || "all" #, meta: pagination_dict(@distributors)
  end

  # GET /distributors/1
  def show
    render json: @distributor, root: "data", adapter: :json,render_attribute: params[:select_distributor] || "all"
  end

  def distributors_by_retailer
    @distributors= Distributor.distributors_by_retailer(params[:retailer_id])
    render json: @distributors, root: "data",render_attribute: params[:select_distributor] || "all"
  end

  def distributor_by_param
    @distributor_by_params= params[:select_distributor].split(',')

    select_colums= @distributor_by_params.map(&:to_sym)

    @select= Distributor.distributor_by_param(select_colums)
    render json: @select, status: :ok, root: "data", render_attribute: params[:select_distributor] || "all"

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distributor
      @distributor = Distributor.distributor_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def distributor_params
      params.fetch(:distributor, {})
    end
end
