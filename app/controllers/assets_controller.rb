class AssetsController < ApplicationController
  def index
    render :show
  end

  def search
    redirect_to accessory_path(params[:id])
  end

  def show
    @asset = Asset.by_bar_code(params[:id])

    respond_to do |format|
      format.html { flash.now[:alert] = "Asset with barcode #{params[:id]} not found" unless @asset.present? }
      format.json { render json: { asset_name: @asset.try(:name) , owner_info: {employee_id: @asset.try(:owner).try(:employee_id) , name: @asset.try(:owner).try(:name) } } }
    end
  end

  def common
    @assets = Asset.common
  end
end
