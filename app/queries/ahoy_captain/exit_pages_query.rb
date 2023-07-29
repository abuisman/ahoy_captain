module AhoyCaptain
  class ExitPagesQuery < ApplicationQuery

    def build
      max_id_query = @query.select("max(id) as id").group("visit_id")
      @query = @query.select(
        "#{AhoyCaptain.config.event[:url_column]} as url",
        "count(#{AhoyCaptain.config.event[:url_column]}) as count",
        "sum(count(#{AhoyCaptain.config.event[:url_column]})) over() as total_count"
      )
                     .where(id: max_id_query)
                     .group(AhoyCaptain.config.event[:url_column])
    end


  end
end
