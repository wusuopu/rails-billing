#!/usr/bin/env ruby
#-*- coding:utf-8 -*-

module Billing
  class API < Grape::API
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    PER_PAGE = 40

    helpers do
      def warden
        env['warden']
      end
      def current_user
        warden.user
      end
      def authenticate!
        handle_not_authenticated unless warden.authenticated?
      end
      def handle_not_authenticated
        error!('401 Unauthorized!', 401)
      end
    end

    before do
      authenticate!
    end

    resource :categories do
      # category list
      # GET /categories
      desc "Return category list."
      get jbuilder: 'category/index' do
        @categories = Category.page(params[:page]).per(PER_PAGE).order(id: 1)
      end
      # Create a new record
      # POST /categories
      desc "Create a new record"
      post do
        begin
          c = Category.create!(
            name: params[:name],
            type: params[:type] || Category::TYPE::EXPENSE,
            parent_id: params[:parent_id]
          )
          {success: true, data: c.id.to_s }
        rescue Exception => e
          error!(e.message, 500)
        end
      end
      # GET categories/all
      desc "Return all category."
      get 'all', jbuilder: 'category/all' do
        @categories = Category.all.order(id: 1)
      end

      desc "Return a category."
      params do
        requires :id, type: String, desc: "Category id."
      end
      route_param :id do
        # category detail
        # GET /categories/:id
        get jbuilder: 'category/category' do
          @category = Category.where(id: params[:id]).first
          error!('404 Not Found', 404) unless @category.present?
        end
        # delete a record
        # DELETE /categories/:id
        delete do
          category = Category.where(id: params[:id]).first
          begin
            category.destroy! if category.present?
            {success: true}
          rescue Exception => e
            error!(e.message, 500)
          end
        end
        # edit a record
        # PUT /categories/:id
        put do
          c = Category.where(id: params[:id]).first
          error!('404 Not Found', 404) unless c.present?

          c.name = params[:name] if params[:name].present?
          c.type = params[:type] if params[:type].present?
          c.parent_id = params[:parent_id] if params[:parent_id].present? && params[:parent_id] != c.parent_id.to_s

          begin
            c.save!
            {success: true, data: c.id.to_s }
          rescue Exception => e
            error!(e.message, 500)
          end
        end
      end
    end
  end
end
