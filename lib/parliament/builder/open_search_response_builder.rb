module Parliament
  module Builder
    # OpenSearch response builder using Feedjira to parse the response.
    #
    # @since 0.1.0
    class OpenSearchResponseBuilder < Parliament::Builder::BaseResponseBuilder
      OPEN_SEARCH_ELEMENTS = %w[totalResults Query startIndex itemsPerPage].freeze

      # Builds a Feedjira::Feed response.  It adds the extra OpenSearch feed elements, then parses the HTTP Response.
      def build
        OPEN_SEARCH_ELEMENTS.each do |element|
          Feedjira::Feed.add_common_feed_element(element)
        end

        # Add custom parser entries for hints
        Feedjira::Parser::AtomEntry.elements(:Name, as: :hint_types)

        # Custom parser for formatted link
        Feedjira::Parser::AtomEntry.element(:link, as: :formatted_url, value: :title)

        Feedjira::Feed.parse(@response.body)
      end
    end
  end
end
