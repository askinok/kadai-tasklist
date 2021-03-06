class TasklistsController < ApplicationController
  before_action :set_tasklist, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasklists = Tasklist.all.page(params[:page]).per(3)
  end

  def show
     set_tasklist
  end

  def new
    @tasklist = Tasklist.new
  end

  def create
    @tasklist = Tasklist.new(tasklist_params)

    if @tasklist.save
      flash[:success] = 'Tasklist が正常に投稿されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'Tasklist が投稿されませんでした'
      render :new
    end
  end

  def edit
    set_tasklist
  end

  def update
    set_tasklist

    if @tasklist.update(tasklist_params)
      flash[:success] = 'Tasklist は正常に更新されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'Tasklist は更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_tasklist
    @tasklist.destroy

    flash[:success] = 'Tasklist は正常に削除されました'
    redirect_to tasklists_url
  end

  private

  # Strong Parameter
  def tasklist_params
    params.require(:tasklist).permit(:content, :status)
  end
  
  def set_tasklist
    @tasklist = Tasklist.find(params[:id])
  end


end
