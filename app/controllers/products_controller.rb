class ProductsController < ApplicationController
  # Only logged-in users can create/update/destroy; anyone can view index/show.
  before_action :authenticate_user!, except: %i[index show]

  # CanCanCan: auto-loads @product / @products and checks permissions for every action.
  load_and_authorize_resource

  # GET /products
  # CanCanCan already sets: @products = Product.accessible_by(current_ability)
  def index; end

  # GET /products/1
  # CanCanCan already sets: @product = Product.find(params[:id])
  def show; end

  # GET /products/new
  # CanCanCan already sets: @product = Product.new
  def new; end

  # GET /products/1/edit
  # CanCanCan already sets: @product = Product.find(params[:id]) and authorizes :edit
  def edit; end

  # POST /products
  def create
    # No need to attach to current_user since only Ali can manage products.
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    # @product is already loaded & authorized by CanCanCan.
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  def destroy
    # @product is already loaded & authorized by CanCanCan.
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Strong params for product creation/update.
  def product_params
    params.require(:product).permit(:name, :description, :price, images: [])
  end
end
