#!/usr/bin/env ruby
#-*- coding:utf-8 -*-

module Billing
  class API < Grape::API
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    PER_PAGE = 20

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

    resource :bills do
      # GET /bills
      desc "Return bill list."
      get jbuilder: 'bill/index' do
        @bills = Bill.page(params[:page]).per(PER_PAGE).order(date: 1)
      end
      # POST /bills
      desc "Create a bill record"
      post do
        begin
          b = Bill.new(
            amount: params[:amount],
            type: params[:type] || Category::TYPE::EXPENSE,
            category_id: params[:category_id],
            title: params[:title],
            description: params[:description]
          )
          b.date = params[:date] if params[:date].present?
          b.save!
          {success: true, data: b.id.to_s }
        rescue Exception => e
          error!(e.message, 500)
        end
      end


      desc "Return a bill."
      params do
        requires :id, type: String, desc: "Bill id."
      end
      route_param :id do
        # GET /bills/:id
        get jbuilder: 'bill/bill' do
          @bill = Bill.where(id: params[:id]).first
          error!('404 Not Found', 404) unless @bill.present?
        end
        # DELETE /bills/:id
        delete do
          bill = Bill.where(id: params[:id]).first
          begin
            bill.destroy! if bill.present?
            {success: true}
          rescue Exception => e
            error!(e.message, 500)
          end
        end
        # PUT /categories/:id
        put do
          b = Bill.where(id: params[:id]).first
          error!('404 Not Found', 404) unless b.present?

          b.amount = params[:amount] if params[:amount].present?
          b.type = params[:type] if params[:type].present?
          b.date = params[:date] if params[:date].present?
          b.title = params[:title] if params[:title]
          b.description = params[:description] if params[:description]
          b.category_id = params[:category_id] if params[:category_id]

          begin
            b.save!
            {success: true, data: b.id.to_s }
          rescue Exception => e
            error!(e.message, 500)
          end
        end

      end
    end
  end
end
