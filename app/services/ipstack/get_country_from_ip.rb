module Ipstack
    class GetCountryFromIp
      include HTTParty
      base_uri "http://api.ipstack.com"

      def initialize(ip_address)
        @ip_address = ip_address
        @api_key = Rails.application.credentials.ipstack_api_key
      end

      def call
        return nil if @ip_address.blank? || @api_key.blank?

        Rails.logger.info "[Ipstack] Dohvaćam državu za IP: #{@ip_address}"

        response = self.class.get("/#{@ip_address}?access_key=#{@api_key}")

        if response.success? && response["country_name"].present?
          Rails.logger.info "[Ipstack] API vratio državu: #{response['country_name']}"
          response["country_name"]
        else
          Rails.logger.error "[Ipstack] Greška: #{response.parsed_response}"
          nil
        end
      end
    end
end
