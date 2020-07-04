# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all.order(created_at: :desc)
  end

  def create
    @url = Url.new(url_params)

    if @url.save
      flash[:notice] = 'Url saved successfully'
    else
      flash[:error] = @url.errors.full_message
    end

    redirect_to root_path
  end

  def show
    @daily_clicks = url.newest_clicks.group_by do |c|
      c.created_at.strftime('%d')
    end.transform_values(&:count).to_a

    @browsers_clicks = url.newest_clicks.group_by do |c|
      c.browser
    end.transform_values(&:count).to_a

    @platform_clicks = url.newest_clicks.group_by do |c|
      c.platform
    end.transform_values(&:count).to_a
  end

  def visit
    browser = Browser.new(request.env['HTTP_USER_AGENT'])

    if url.persisted?
      new_click = url.register_click(browser)
      url.register_counter_click if new_click

      redirect_to url.original_url, status: :moved_permanently
    end
  end

  private

  def url
    @url = Url.find_by(short_url: params[:url])
  end

  def url_params
    params.require(:url)
          .permit(:original_url)
  end
end
