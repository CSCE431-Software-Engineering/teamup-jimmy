# frozen_string_literal: true

module ApplicationHelper
    def mobile_device?
        request.user_agent =~ /Mobile|webOS/
    end
end
