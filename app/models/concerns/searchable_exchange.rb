# frozen_string_literal: true

module SearchableExchange
  extend ActiveSupport::Concern

  included do
    searchable do
      text :title
      string :type
      integer :poster_id
      integer :last_poster_id
      boolean :closed
      boolean :sticky
      time :created_at
      time :updated_at
      time :last_post_at
    end
  end

  module ClassMethods
    def search_results(query, options = {})
      search = Discussion.search do
        fulltext query
        order_by :last_post_at, :desc
        paginate page: options[:page], per_page: Exchange.per_page
      end
      search
    end
  end
end
