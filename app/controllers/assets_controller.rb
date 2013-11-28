class AssetsController < ApplicationController
  def index
    render :show
  end

  def search
    redirect_to accessory_path(params[:id])
  end

  def show
    @asset = Asset.by_bar_code(params[:id])
    flash.now[:alert] = "Asset with barcode #{params[:id]} not found" unless @asset.present?
  end

  def common
    @assets = Asset.common
  end
end
