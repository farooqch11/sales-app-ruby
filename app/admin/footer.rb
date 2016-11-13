module ActiveAdmin
  module Views
    class Footer < Component

      def build
        super id: "footer"
        super style: "text-align: right;"

        div do
          small ""
        end
      end

    end
  end
end