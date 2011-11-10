module FormHelper
  def buttons(&block)
    content_tag :div, class: "buttons" do
      block.call
    end
  end
end
