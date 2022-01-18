# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  resources :articles
end
