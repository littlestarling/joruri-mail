class Sys::Admin::LanguagesController < Sys::Controller::Admin::Base
  include Sys::Controller::Scaffold::Base

  def pre_dispatch
    return error_auth unless Core.user.has_auth?(:manager)
  end

  def index
    @items = Sys::Language.order(:sort_no).paginate(page: params[:page], per_page: params[:limit])
    _index @items
  end

  def show
    @item = Sys::Language.find(params[:id])
    #return error_auth unless @item.readable?

    _show @item
  end

  def new
    @item = Sys::Language.new(state: 'enabled')
  end

  def create
    @item = Sys::Language.new(item_params)
    _create @item
  end

  def update
    @item = Sys::Language.find(params[:id])
    @item.attributes = item_params
    _update @item
  end

  def destroy
    @item = Sys::Language.find(params[:id])
    _destroy @item
  end

private

  def item_params
    params.require(:item).permit(:state, :name, :title, :sort_no)
  end
end
